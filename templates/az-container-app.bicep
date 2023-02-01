targetScope = 'subscription'

param environment string = 'dev'
param owner string = 'Chendrayan Venkatesan'
param costcenter string = 'AZ-0023'
param suffix string = 'dev'
param location string = 'northeurope'
param logAnalyticsName string = 'Law-Containers-App'
param kubeEnvironmentName string = 'Kube-Environment'
param containerAppName string = 'colorsofcuisine'
param registryPassword string
// @secure()
// param registryPassword string

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'colorsofcuisine-${suffix}'
  location: location
  tags: {
    'env': environment
    'owner': owner
    'costcenter': costcenter
  }
}

module LogAnalyticsworkSpace 'modules/az-log-analytics/log-analytics.bicep' = {
  name: 'log-analytics-deployment'
  scope: resourceGroup(rg.name)
  params: {
    logAnalyticsName: '${logAnalyticsName}-${suffix}'
    environment:environment
    owner:owner
    costcenter:costcenter
  }
}

module kubeEnvironment 'modules/az-kube-environment/az-kube-environment.bicep' = {
  name: 'kube-deployment-${suffix}'
  params: {
    customerId: LogAnalyticsworkSpace.outputs.customerId
    primarySharedKey: LogAnalyticsworkSpace.outputs.primarySharedKey
    kubeEnvironmentName: '${kubeEnvironmentName}-${suffix}'
  }
  scope: resourceGroup(rg.name)
}

module containerApp 'modules/az-container-app/container-app.bicep' = {
  name: '${containerAppName}-${suffix}'
  scope: resourceGroup(rg.name)
  params: {
    kubeEnvironmentId: kubeEnvironment.outputs.kubeEnvironmentId
    registryPassword: registryPassword
    containerAppName: containerAppName
  }
}
