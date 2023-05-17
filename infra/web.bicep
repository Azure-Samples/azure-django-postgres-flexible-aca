param name string
param location string = resourceGroup().location
param tags object = {}

param applicationInsightsName string
param containerAppsEnvironmentName string
param containerRegistryName string
param exists bool
param identityName string
param keyVaultName string
param serviceName string = 'web'
param postgresDomainName string
param postgresDatabaseName string
param postgresUser string
@secure()
param postgresPassword string
@secure()
param djangoSecretKey string

resource webIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: identityName
  location: location
}

module app 'core/host/container-app-upsert.bicep' = {
  name: '${serviceName}-container-app-module'
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
        value: postgresDomainName
      }
      {
        name: 'POSTGRES_USER'
        value: postgresUser
      }
      {
        name: 'POSTGRES_DB'
        value: postgresDatabaseName
      }
      {
        name: 'DJANGO_POSTGRES_KEYVAULT'
        value: keyVault.name
      }
      {
        name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
        value: applicationInsights.properties.ConnectionString
      }
      {
        name: 'DJANGO_SECRET_KEY'
        secretRef: 'django-secret-key'
      }
      {
        name: 'POSTGRES_PASSWORD'
        secretRef: 'postgres-password'
      }
      ]
    secrets: [
        {
          name: 'postgres-password'
          value: postgresPassword
        }
        {
          name: 'django-secret-key'
          value: djangoSecretKey
        }
      ]
    targetPort: 8000 
  }
}

resource keyVault 'Microsoft.KeyVault/vaults@2022-07-01' existing = {
  name: keyVaultName
}

resource applicationInsights 'Microsoft.Insights/components@2020-02-02' existing = {
  name: applicationInsightsName
}

output SERVICE_WEB_IDENTITY_PRINCIPAL_ID string = webIdentity.properties.principalId
output SERVICE_WEB_NAME string = app.outputs.name
output SERVICE_WEB_URI string = app.outputs.uri
output SERVICE_WEB_IMAGE_NAME string = app.outputs.imageName
