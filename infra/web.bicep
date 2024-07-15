param name string
param location string = resourceGroup().location
param tags object = {}

param applicationInsightsName string
param containerAppsEnvironmentName string
param containerRegistryName string
param exists bool
param identityName string
param serviceName string = 'web'
param keyVaultName string
param dbserverDomainName string
param dbserverDatabaseName string
param dbserverUser string

@secure()
param dbserverPassword string

resource keyVault 'Microsoft.KeyVault/vaults@2022-07-01' existing = {
  name: keyVaultName
}

resource webIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: identityName
  location: location
}

module keyVaultRoleAssignment 'core/security/role.bicep' = {
  name: 'webRoleAssignment'
  params: {
    principalId: webIdentity.properties.principalId
    roleDefinitionId: '4633458b-17de-408a-b874-0445c86b69e6' // Key Vault Secrets User
  }
}

module app 'core/host/container-app-upsert.bicep' = {
  name: '${serviceName}-container-app-module'
  dependsOn: [keyVaultRoleAssignment]
  params: {
    name: name
    location: location
    tags: union(tags, { 'azd-service-name': serviceName })
    identityName: webIdentity.name
    exists: exists
    containerAppsEnvironmentName: containerAppsEnvironmentName
    containerRegistryName: containerRegistryName
    env: [
      {
        name: 'POSTGRES_HOST'
        value: dbserverDomainName
      }
      {
        name: 'POSTGRES_USERNAME'
        value: dbserverUser
      }
      {
        name: 'POSTGRES_DATABASE'
        value: dbserverDatabaseName
      }
      {
        name: 'POSTGRES_PASSWORD'
        secretRef: 'dbserver-password'
      }
      {
        name: 'POSTGRES_SSL'
        value: 'require'
      }
      {
        name: 'RUNNING_IN_PRODUCTION'
        value: 'true'
      }
      {
        name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
        value: applicationInsights.properties.ConnectionString
      }
      {
        name: 'SECRET_KEY'
        secretRef: 'secret-key'
      }
      ]
    secrets: {
          'dbserver-password': dbserverPassword
     }
    keyvaultIdentities: {
      'secret-key': {
        keyVaultUrl: '${keyVault.properties.vaultUri}secrets/SECRETKEY'
        identity: webIdentity.id
      }
    }
    targetPort: 8000
  }
}

resource applicationInsights 'Microsoft.Insights/components@2020-02-02' existing = {
  name: applicationInsightsName
}

output SERVICE_WEB_IDENTITY_PRINCIPAL_ID string = webIdentity.properties.principalId
output SERVICE_WEB_NAME string = app.outputs.name
output SERVICE_WEB_URI string = app.outputs.uri
output SERVICE_WEB_IMAGE_NAME string = app.outputs.imageName

output uri string = app.outputs.uri
