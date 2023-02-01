param customerId string
param primarySharedKey string
param kubeEnvironmentName string

resource kubeEnvironment 'Microsoft.Web/kubeEnvironments@2021-01-15' = {
  name: kubeEnvironmentName
  location: 'northeurope'
  properties: {
    type: 'managed'
    appLogsConfiguration: {
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        customerId: customerId
        sharedKey: primarySharedKey
      }
    }
  }
}
output kubeEnvironmentId string = kubeEnvironment.id
