targetScope = 'subscription'

@minLength(1)
@maxLength(64)
@description('Name which is used to generate a short unique hash for each resource')
param name string

@minLength(1)
@description('Primary location for all resources')
param location string

@secure()
@description('DBServer administrator password')
param dbserverPassword string

@secure()
@description('Secret Key')
param secretKey string

param webAppExists bool = false

@description('Id of the user or app to assign application roles')
param principalId string = ''

var resourceToken = toLower(uniqueString(subscription().id, name, location))
var prefix = '${name}-${resourceToken}'
var tags = { 'azd-env-name': name }

var secrets = [
  {
    name: 'DBSERVERPASSWORD'
    value: dbserverPassword
  }
  {
    name: 'SECRETKEY'
    value: secretKey
  }
]

resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${name}-rg'
  location: location
  tags: tags
}

module virtualNetwork 'br/public:avm/res/network/virtual-network:0.1.8' = {
  name: 'virtualNetworkDeployment'
  scope: resourceGroup
  params: {
    // Required parameters
    addressPrefixes: [
      '10.0.0.0/16'
    ]
    name: '${name}-vnet'
    location: location
    tags: tags
    subnets: [
      {
        addressPrefix: '10.0.0.0/24'
        name: 'keyvault'
        tags: tags
      }
      {
        addressPrefix: '10.0.2.0/23'
        name: 'web'
        tags: tags
        serviceEndpoints: [
          {
            service: 'Microsoft.KeyVault'
          }
        ]
      }
    ]
  }
}

module privateDnsZone 'br/public:avm/res/network/private-dns-zone:0.3.1' = {
  name: 'privateDnsZoneDeployment'
  scope: resourceGroup
  params: {
    name: 'relecloud.net'
    tags: tags
  }
}

// Store secrets in a keyvault
module keyVault 'br/public:avm/res/key-vault/vault:0.6.2' = {
  name: 'keyvault'
  scope: resourceGroup
  params: {
    name: '${take(replace(prefix, '-', ''), 17)}-vault'
    location: location
    tags: tags
    sku: 'standard'
    enableRbacAuthorization: true
    accessPolicies: [
      {
        objectId: principalId
        permissions: { secrets: ['get', 'list'] }
        tenantId: subscription().tenantId
      }
    ]
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Deny'
      // ipRules: [
      //   { value: '<your IP>' }
      // ]
      virtualNetworkRules: [
        {
          id: virtualNetwork.outputs.subnetResourceIds[1]
        }
      ]
    }
    privateEndpoints: [
      {
        name: '${name}-keyvault-pe'
        subnetResourceId: virtualNetwork.outputs.subnetResourceIds[0]
        privateDnsZoneResourceIds: [privateDnsZone.outputs.resourceId]
      }
    ]
    diagnosticSettings: [
      {
        logCategoriesAndGroups: [
          {
            category: 'AuditEvent'
          }
        ]
        name: 'auditEventLogging'
        workspaceResourceId: monitoring.outputs.logAnalyticsWorkspaceId
      }
    ]
    secrets: [
      for secret in secrets: {
        name: secret.name
        value: secret.value
        tags: tags
        attributes: {
          exp: 0
          nbf: 0
        }
      }
    ]
  }
}

module roleAssignment 'core/security/role.bicep' = {
  name: 'webRoleAssignment'
  scope: resourceGroup
  params: {
    principalId: web.outputs.SERVICE_WEB_IDENTITY_PRINCIPAL_ID
    roleDefinitionId: '4633458b-17de-408a-b874-0445c86b69e6' // Key Vault Secrets User
  }
}

module db 'db.bicep' = {
  name: 'db'
  scope: resourceGroup
  params: {
    name: 'dbserver'
    location: location
    tags: tags
    prefix: prefix
    dbserverDatabaseName: 'relecloud'
    dbserverPassword: dbserverPassword
  }
}

// Monitor application with Azure Monitor
module monitoring 'core/monitor/monitoring.bicep' = {
  name: 'monitoring'
  scope: resourceGroup
  params: {
    location: location
    tags: tags
    applicationInsightsDashboardName: '${prefix}-appinsights-dashboard'
    applicationInsightsName: '${prefix}-appinsights'
    logAnalyticsName: '${take(prefix, 50)}-loganalytics' // Max 63 chars
  }
}

// Container apps host (including container registry)
module containerApps 'core/host/container-apps.bicep' = {
  name: 'container-apps'
  scope: resourceGroup
  params: {
    name: 'app'
    location: location
    containerAppsEnvironmentName: '${prefix}-containerapps-env'
    containerRegistryName: '${replace(prefix, '-', '')}registry'
    logAnalyticsWorkspaceResourceId: monitoring.outputs.logAnalyticsWorkspaceId
    virtualNetworkSubnetId: virtualNetwork.outputs.subnetResourceIds[1]
  }
}

// Web frontend
module web 'web.bicep' = {
  name: 'web'
  scope: resourceGroup
  params: {
    name: replace('${take(prefix,19)}-ca', '--', '-')
    location: location
    tags: tags
    applicationInsightsName: monitoring.outputs.applicationInsightsName
    keyVaultName: keyVault.outputs.name
    identityName: '${prefix}-id-web'
    containerAppsEnvironmentName: containerApps.outputs.environmentName
    containerRegistryName: containerApps.outputs.registryName
    exists: webAppExists
    dbserverDomainName: db.outputs.dbserverDomainName
    dbserverUser: db.outputs.dbserverUser
    dbserverDatabaseName: db.outputs.dbserverDatabaseName
    dbserverPassword: dbserverPassword
  }
}

output AZURE_LOCATION string = location
output AZURE_CONTAINER_ENVIRONMENT_NAME string = containerApps.outputs.environmentName
output AZURE_CONTAINER_REGISTRY_ENDPOINT string = containerApps.outputs.registryLoginServer
output AZURE_CONTAINER_REGISTRY_NAME string = containerApps.outputs.registryName
output SERVICE_WEB_IDENTITY_PRINCIPAL_ID string = web.outputs.SERVICE_WEB_IDENTITY_PRINCIPAL_ID
output SERVICE_WEB_NAME string = web.outputs.SERVICE_WEB_NAME
output SERVICE_WEB_URI string = web.outputs.SERVICE_WEB_URI
output SERVICE_WEB_IMAGE_NAME string = web.outputs.SERVICE_WEB_IMAGE_NAME
output AZURE_KEY_VAULT_ENDPOINT string = keyVault.outputs.uri
output AZURE_KEY_VAULT_NAME string = keyVault.outputs.name
output APPLICATIONINSIGHTS_NAME string = monitoring.outputs.applicationInsightsName

output BACKEND_URI string = web.outputs.uri
