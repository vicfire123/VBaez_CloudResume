// Azure Static Web App that hosts this resume.
//
// Reference infrastructure-as-code only. It is NOT wired into CI: the site is
// deployed by the GitHub Actions workflow in .github/workflows using the
// app's deployment token. Run it by hand if the app ever needs recreating:
//
//   az deployment group create -g <resource-group> -f infra/main.bicep

@description('Name of the Static Web App resource.')
param staticWebAppName string

@description('Region for the resource metadata. Static content is served globally.')
@allowed([
  'centralus'
  'eastus2'
  'westus2'
  'westeurope'
  'eastasia'
])
param location string = 'eastus2'

@description('Hosting plan. Free covers a personal static site.')
@allowed([
  'Free'
  'Standard'
])
param sku string = 'Free'

param tags object = {
  project: 'cloud-resume'
}

resource staticWebApp 'Microsoft.Web/staticSites@2023-12-01' = {
  name: staticWebAppName
  location: location
  tags: tags
  sku: {
    name: sku
    tier: sku
  }
  properties: {
    // Content is pushed by GitHub Actions with the deployment token, so no
    // repository link is configured on the resource itself.
    allowConfigFileUpdates: true
    stagingEnvironmentPolicy: 'Enabled'
  }
}

output defaultHostname string = staticWebApp.properties.defaultHostname
output resourceId string = staticWebApp.id
