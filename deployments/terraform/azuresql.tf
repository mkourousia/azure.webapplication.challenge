resource "azurerm_mssql_server" "skedda_challenge_mssql_server" {
  name                         = "${var.prefix}-mssql-server"
  location                     = azurerm_resource_group.skedda_challenge_resource_group.location
  resource_group_name          = azurerm_resource_group.skedda_challenge_resource_group.name
  version                      = var.azure_mssql_version
  administrator_login          = var.azure_mssql_username
  administrator_login_password = var.azure_mssql_password
  tags                         = var.tags


  dynamic "azuread_administrator" {
    for_each = var.azuread_administrator == null ? [] : [1]
    content {
      login_username              = var.azuread_administrator["login_username"]
      object_id                   = var.azuread_administrator["object_id"]
      tenant_id                   = var.azuread_administrator["tenant_id"]
      azuread_authentication_only = var.azuread_administrator["azuread_authentication_only"]
    }
  }

  connection_policy                    = var.connection_policy
  minimum_tls_version                  = var.minimum_tls_version
  public_network_access_enabled        = var.public_network_access_enabled
  outbound_network_restriction_enabled = var.outbound_network_restriction_enabled

}

resource "azurerm_mssql_database" "skedda_challenge_mssql_db" {
  name           = "${prefix}-mssql-db"
  server_id      = azurerm_mssql_server.skedda_challenge_mssql_server.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 4
  read_scale     = true
  sku_name       = "S0"
  zone_redundant = true

  tags = {
    app    = "aspnetcoreapp"
    region = var.location
  }
}