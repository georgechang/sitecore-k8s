param prefix string = 'sitecore-k8s'
param location string = 'eastus'

resource sql 'Microsoft.Sql/servers@2019-06-01-preview' = {
  name: '${prefix}-sql'
  location: location
  properties: {
    administratorLogin: 'sitecore'
    administratorLoginPassword: 'pass@word1'
  }
}

resource pool 'Microsoft.Sql/servers/elasticPools@2020-08-01-preview' = {
  name: '${sql.name}/${prefix}-pool'
  location: location
  sku: {
    name: 'GP_Gen5'
    tier: 'GeneralPurpose'
    family: 'Gen5'
    capacity: 2
  }
  properties: {
    licenseType: 'LicenseIncluded'
  }
}

resource db 'Microsoft.Sql/servers/databases@2020-08-01-preview' = {
  name: '${sql.name}/${prefix}-core'
  location: location
  properties: {
    elasticPoolId: pool.id
    licenseType: 'LicenseIncluded'
  }
}