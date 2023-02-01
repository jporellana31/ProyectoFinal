param suffix string
// param dockerImageName string = 'DOCKER|chenv/collabrains.cloud:v1.0.1'
param dockerImageName string

resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: 'asp-colors-of-cuisines-${suffix}'
  location: resourceGroup().location
  sku: {
    name: 'P1v2'
    tier: 'PremiumV2'
    size: 'P1v2'
    family: 'Pv2'
    capacity: 1
  }
  kind: 'app,linux'
  properties: {
    perSiteScaling: false
    reserved: true
    maximumElasticWorkerCount: 1
  }
}

resource webApplication 'Microsoft.Web/sites@2018-11-01' = {
  name: 'colors-of-cuisines-${suffix}'
  location: resourceGroup().location
  kind: 'app,linux,container'
  tags: {
    'hidden-related:${resourceGroup().id}/providers/Microsoft.Web/serverfarms/appServicePlan': 'Resource'
  }
  properties: {
    enabled: true
    serverFarmId: appServicePlan.id
    reserved: true
    isXenon: false
    hyperV: false
    siteConfig: {
      numberOfWorkers: 1
      alwaysOn: true
      linuxFxVersion: 'DOCKER|${dockerImageName}'
      appSettings: [
        {
          name: 'WEBSITES_ENABLE_APP_SERVICE_STORAGE'
          value: 'false'
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_URL'
          value: 'https://index.docker.io '
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_USERNAME'
          value: ''
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_PASSWORD'
          value: ''
        }
      ]
    }
  }
}
