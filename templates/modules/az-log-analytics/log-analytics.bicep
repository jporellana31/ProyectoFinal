param logAnalyticsName string
param environment string
param owner string
param costcenter string

resource law 'Microsoft.OperationalInsights/workspaces@2020-03-01-preview' = {
  name: logAnalyticsName
  location: resourceGroup().location
  properties: any({
    retentionInDays: 30
    features: {
      searchVersion: 1
    }
    sku: {
      name: 'PerGB2018'
    }
  })
  tags:{
    'env': environment
    'owner': owner
    'costcenter': costcenter
  }
}
output customerId string = law.properties.customerId
output primarySharedKey string = listKeys(law.id,law.apiVersion).primarySharedKey
