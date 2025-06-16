param webAppName string = uniqueString(resourceGroup().id) // Generate unique String for web app name
param sku string = 'S1' // The SKU of App Service Planparam location string = resourceGroup().location
var appServicePlanName = toLower('AppServicePlan-${webAppName}')

resource appServicePlan 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: appServicePlanName
  location: koreacentral
  properties: {
    reserved: true
  }
  sku: {
    name: sku
  }
}
resource appService 'Microsoft.Web/sites@2022-09-01' = {
  name: webAppName
  kind: 'app'
  location: koreacentral
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE|8.0'
      appSettings: [
        {
          name: 'ASPNETCORE_ENVIRONMENT'
          value: 'Development'
        }
        {
          name: 'UseOnlyInMemoryDatabase'
          value: 'true'
        }
      ]
    }
  }
}
