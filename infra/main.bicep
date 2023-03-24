targetScope = 'subscription'

@minLength(1)
@maxLength(64)
@description('Name of the the environment which is used to generate a short unique hash used in all resources.')
param name string

@minLength(1)
@description('Primary location for all resources')
param location string

@secure()
@description('PostGreSQL Server administrator password')
param databasePassword string

@secure()
@description('Django SECRET_KEY for securing signed data')
param secretKey string

var resourceToken = toLower(uniqueString(subscription().id, name, location))
var tags = { 'azd-env-name': name }

resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${name}-rg'
  location: location
  tags: tags
}

module resources 'resources.bicep' = {
  name: 'resources'
  scope: resourceGroup
  params: {
    location: location
    resourceToken: resourceToken
    tags: tags
    databasePassword: databasePassword
    secretKey: secretKey
  }
}

output APPLICATIONINSIGHTS_CONNECTION_STRING string = resources.outputs.APPLICATIONINSIGHTS_CONNECTION_STRING
output AZURE_LOAD_TEST_NAME string = resources.outputs.AZURE_LOAD_TEST_NAME
output AZURE_LOAD_TEST_HOST string = resources.outputs.AZURE_LOAD_TEST_HOST
output AZURE_RESOURCE_GROUP_NAME string = resourceGroup.name
output AZURE_LOCATION string = location

