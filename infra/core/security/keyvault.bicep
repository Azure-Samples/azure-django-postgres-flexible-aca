metadata description = 'Creates an Azure Key Vault.'
param name string
param location string = resourceGroup().location
param logAnalyticsWorkspaceId string
param tags object = {}

param principalId string = ''

@description('List of IP addresses or IP address ranges in CIDR format that are allowed to access the key vault.')
param ipRules array = []

// Allow all Azure services to bypass Key Vault network rules
param allowAzureServicesAccess bool = true

resource keyVault 'Microsoft.KeyVault/vaults@2022-07-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    tenantId: subscription().tenantId
    sku: { family: 'A', name: 'standard' }
    networkAcls: {
      bypass: allowAzureServicesAccess ? 'AzureServices' : 'None'
      defaultAction: 'Deny'
      ipRules: ipRules
      virtualNetworkRules: []
    }
    enableRbacAuthorization: true
    accessPolicies: !empty(principalId) ? [
      {
        objectId: principalId
        permissions: { secrets: [ 'get', 'list' ] }
        tenantId: subscription().tenantId
      }
    ] : []
  }
}

resource logs 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'logs'
  scope: keyVault
  properties: {
    workspaceId: logAnalyticsWorkspaceId
    logs: [
      {
        category: 'AuditEvent'
        enabled: true
      }
    ]
  }
}

output endpoint string = keyVault.properties.vaultUri
output id string = keyVault.id
output name string = keyVault.name
