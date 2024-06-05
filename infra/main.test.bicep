// This file is for doing static analysis and contains sensible defaults
// for the template analyser to minimise false-positives and provide the best results.

// This file is not intended to be used as a runtime configuration file.

targetScope = 'subscription'

param environmentName string = 'testing'
param location string = 'westus2'

@secure()
param dbserverPassword string = newGuid()

@secure()
param secretKey string = newGuid()

module main 'main.bicep' = {
  name: 'main'
  params: {
    name: environmentName
    location: location
    // These are used for static analysis and never deployed
    dbserverPassword: dbserverPassword
    secretKey: secretKey
  }
}
