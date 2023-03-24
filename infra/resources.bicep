param location string
param resourceToken string
@secure()
param databasePassword string
@secure()
param secretKey string
param tags object

var abbrs = loadJsonContent('abbreviations.json')
var databaseSubnetName = 'database-subnet'
var webappSubnetName = 'webapp-subnet'
resource virtualNetwork 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: '${abbrs.networkVirtualNetworks}${resourceToken}'
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: databaseSubnetName
        properties: {
          addressPrefix: '10.0.0.0/24'
          delegations: [
            {
              name: 'subnet-delegation-${resourceToken}'
              properties: {
                serviceName: 'Microsoft.DBforPostgreSQL/flexibleServers'
              }
            }
          ]
        }
      }
      {
        name: webappSubnetName
        properties: {
          addressPrefix: '10.0.1.0/24'
          delegations: [
            {
              name: 'subnet-delegation-${resourceToken}-web'
              properties: {
                serviceName: 'Microsoft.Web/serverFarms'
              }
            }
          ]
        }
      }
    ]
  }
  resource databaseSubnet 'subnets' existing = {
    name: databaseSubnetName
  }
  resource webappSubnet 'subnets' existing = {
    name: webappSubnetName
  }
}

resource privateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: '${abbrs.dBforPostgreSQLServers}${resourceToken}.private.postgres.database.azure.com'
  location: 'global'
  tags: tags
  dependsOn: [
    virtualNetwork
  ]
}

resource privateDnsZoneLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  parent: privateDnsZone
  name: '${abbrs.dBforPostgreSQLServers}${resourceToken}-link'
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: virtualNetwork.id
    }
  }
}

resource web 'Microsoft.Web/sites@2022-03-01' = {
  name: '${abbrs.webSitesAppService}${resourceToken}'
  location: location
  tags: union(tags, { 'azd-service-name': 'web' })
  kind: 'app,linux'
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      alwaysOn: true
      linuxFxVersion: 'PYTHON|3.11'
      ftpsState: 'Disabled'
      appCommandLine: 'startup.sh'
      minTlsVersion: '1.2'
    }
    httpsOnly: true
  }

  identity: {
    type: 'SystemAssigned'
  }

  resource appSettings 'config' = {
    name: 'appsettings'
    properties: {
      DATABASE_USERNAME: postgresdb.properties.administratorLogin
      DATABASE_PASSWORD: databasePassword
      DATABASE_ADDRESS: '${abbrs.dBforPostgreSQLServers}${resourceToken}.postgres.database.azure.com'
      AZURE_STORAGEACCOUNT_KEY: storage.listKeys().keys[0].value
      AZURE_STORAGEACCOUNT_NAME: storage.name
      AZURE_MEDIA_CONTAINER: 'media'
      AZURE_STATIC_CONTAINER: 'static'
      SCM_DO_BUILD_DURING_DEPLOYMENT: 'true'
      APPLICATIONINSIGHTS_CONNECTION_STRING: applicationInsightsResources.outputs.APPLICATIONINSIGHTS_CONNECTION_STRING
      SECRET_KEY: secretKey
    }
  }

  resource logs 'config' = {
    name: 'logs'
    properties: {
      applicationLogs: {
        fileSystem: {
          level: 'Verbose'
        }
      }
      detailedErrorMessages: {
        enabled: true
      }
      failedRequestsTracing: {
        enabled: true
      }
      httpLogs: {
        fileSystem: {
          enabled: true
          retentionInDays: 1
          retentionInMb: 35
        }
      }
    }
  }

  resource webappVnetConfig 'networkConfig' = {
    name: 'virtualNetwork'
    properties: {
      subnetResourceId: virtualNetwork::webappSubnet.id
    }
  }

  dependsOn: [virtualNetwork]
}

resource appServicePlan 'Microsoft.Web/serverfarms@2021-03-01' = {
  name: '${abbrs.webServerFarms}${resourceToken}'
  location: location
  tags: tags
  sku: {
    name: 'P3V2'
  }
  properties: {
    reserved: true
  }
}

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2020-03-01-preview' = {
  name: '${abbrs.operationalInsightsWorkspaces}${resourceToken}'
  location: location
  tags: tags
  properties: any({
    retentionInDays: 30
    features: {
      searchVersion: 1
    }
    sku: {
      name: 'PerGB2018'
    }
  })
}

module applicationInsightsResources 'applicationinsights.bicep' = {
  name: 'applicationinsights-resources'
  params: {
    resourceToken: resourceToken
    location: location
    tags: tags
    workspaceId: logAnalyticsWorkspace.id
  }
}


resource postgresdb 'Microsoft.DBforPostgreSQL/flexibleServers@2022-01-20-preview' = {
  location: location
  tags: tags
  name: '${abbrs.dBforPostgreSQLServers}${resourceToken}'
  sku: {
    name: 'Standard_D2ds_v4'
    tier: 'GeneralPurpose'
  }
  properties: {
    version: '13'
    administratorLogin: 'django'
    administratorLoginPassword: databasePassword
    storage: {
      storageSizeGB: 128
    }
    backup: {
      backupRetentionDays: 7
      geoRedundantBackup: 'Disabled'
    }
    network: {
      delegatedSubnetResourceId: virtualNetwork::databaseSubnet.id
      privateDnsZoneArmResourceId: privateDnsZone.id
    }
    highAvailability: {
      mode: 'Disabled'
    }
    maintenanceWindow: {
      customWindow: 'Disabled'
      dayOfWeek: 0
      startHour: 0
      startMinute: 0
    }
  }
  dependsOn: [
    privateDnsZoneLink
  ]

  resource djangoDatabase 'databases@2022-01-20-preview' = {
    name: 'django'
    properties: {
      // Azure defaults to UTF-8 encoding, override if required.
      // charset: 'string' 
      // collation: 'string'
    }
  }
}

resource storage 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  name: '${abbrs.storageStorageAccounts}${resourceToken}'
  location: location
  tags: tags
  properties: {
    dnsEndpointType: 'Standard'
    defaultToOAuthAuthentication: false
    publicNetworkAccess: 'Enabled'
    allowCrossTenantReplication: true
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: true
    allowSharedKeyAccess: true
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      requireInfrastructureEncryption: false
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
    accessTier: 'Hot'
  }
}

resource blobservices 'Microsoft.Storage/storageAccounts/blobServices@2021-09-01' = {
  name: 'default'
  parent: storage
}

resource static 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-09-01' = {
  name: 'static'
  parent: blobservices
  properties: {
    publicAccess: 'Blob'
  }
}

resource media 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-09-01' = {
  name: 'media'
  parent: blobservices
  properties: {
    publicAccess: 'Blob'
  }
}

resource loadtest 'Microsoft.LoadTestService/loadTests@2022-12-01' = {
  name: 'loadtest-${resourceToken}'
  location: location
  tags: tags
  identity: {
    type: 'None'
  }
  properties: {
  }
}

output APPLICATIONINSIGHTS_CONNECTION_STRING string = applicationInsightsResources.outputs.APPLICATIONINSIGHTS_CONNECTION_STRING
output WEB_URI string = 'https://${web.properties.defaultHostName}'
output AZURE_LOAD_TEST_NAME string = loadtest.name
output AZURE_LOAD_TEST_HOST string = web.properties.defaultHostName
