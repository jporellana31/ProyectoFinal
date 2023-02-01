targetScope = 'subscription'

param suffix string
param dockerImageName string

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rgp-colors-of-cuisine-${suffix}'
  location: 'eastus2'
  tags: {
    'env': 'development'
    'owner': 'chendrayan venkatesan'
    'costcenter': 'AZ-0001'
  }
}


module webapp 'web-app.bicep' = {
  name: 'webapp-deployment'
  scope: resourceGroup(rg.name)
  params: {
    suffix: suffix 
    dockerImageName: dockerImageName
  }
}
