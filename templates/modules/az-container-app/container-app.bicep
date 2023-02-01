param kubeEnvironmentId string
param containerAppName string
param userName string = 'chenv'
param registryPassword string
param targetPort int = 80
param image string = 'chenv/collabrains.cloud:v1.0.3'

param ingress object = {
  external: true
  targetPort: targetPort
  transport: 'auto'
}

resource containerApp 'Microsoft.Web/containerapps@2021-03-01' = {
  name: containerAppName
  location: resourceGroup().location
  properties: {
    kubeEnvironmentId: kubeEnvironmentId
    configuration: {
      secrets: [
        {
          name: 'container-registry-password'
          value: registryPassword
        }
      ]
      registries: [
        {
          server: 'docker.io'
          username: userName
          PasswordSecretRef: 'container-registry-password'
        }
      ]
      ingress: ingress
    }
    template: {
      containers: [
        {
          image: image
          name: 'collabrains'
          resources: {
            cpu: '.25'
            memory: '.5Gi'
          }
        }
      ]
    }
  }
}
