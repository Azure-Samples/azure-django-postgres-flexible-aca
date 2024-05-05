metadata description = 'Creates an Azure Frontdoor CDN profile in front of a storage domain.'

param name string
param origin string
param tags object = {}
param allowHttp bool = false
param httpsRedirect bool = true
param defaultRouteName string = 'default-route'
param defaultOriginGroupName string = 'default-origin-group'
param defaultOriginName string = 'default-origin'

@allowed(['Enabled', 'Disabled'])
param sessionAffinityState string = 'Disabled'

var supportedProtocols = allowHttp ? [
  'Http'
  'Https'
] : [
  'Https'
]

@allowed(['Standard_AzureFrontDoor', 'Premium_AzureFrontDoor'])
param sku string = 'Standard_AzureFrontDoor'

param originResponseTimeoutSeconds int = 60

resource cdnProfile 'Microsoft.Cdn/profiles@2023-07-01-preview' = {
  name: name
  location: 'Global'
  tags: tags
  sku: {
    name: sku
  }
  properties: {
    originResponseTimeoutSeconds: originResponseTimeoutSeconds
  }
}

resource originGroups 'Microsoft.Cdn/profiles/origingroups@2022-11-01-preview' = {
  name: defaultOriginGroupName
  parent: cdnProfile
  properties: {
    loadBalancingSettings: {
      sampleSize: 4
      successfulSamplesRequired: 3
      additionalLatencyInMilliseconds: 50
    }
    healthProbeSettings: {
      probePath: '/'
      probeRequestType: 'HEAD'
      probeProtocol: allowHttp ? 'Http' : 'Https'
      probeIntervalInSeconds: 100
    }
    sessionAffinityState: sessionAffinityState
  }

  resource origins 'origins@2022-11-01-preview' = {
    name: defaultOriginName
    properties: {
      hostName: origin
      httpPort: 80
      httpsPort: 443
      originHostHeader: origin
      priority: 1
      weight: 1000
      enabledState: 'Enabled'
      enforceCertificateNameCheck: true
    }
  }
}

resource afdEndpoints 'Microsoft.Cdn/profiles/afdEndpoints@2023-05-01' = {
  parent: cdnProfile
  name: name
  location: 'Global'
  properties: {
    enabledState: 'Enabled'
  }

  resource routes 'routes@2022-11-01-preview' = {
    name: defaultRouteName
    properties: {
      customDomains: []
      originGroup: {
        id: originGroups.id
      }
      ruleSets: []
      supportedProtocols: supportedProtocols
      patternsToMatch: [
        '/*'
      ]
      forwardingProtocol: 'MatchRequest'
      linkToDefaultDomain: 'Enabled'
      httpsRedirect: httpsRedirect ? 'Enabled' : 'Disabled'
      enabledState: 'Enabled'
    }
  }
}

output cdnProfileId string = cdnProfile.id
output endpointHostname string = afdEndpoints.properties.hostName
