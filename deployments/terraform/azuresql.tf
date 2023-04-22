resource "azurerm_mssql_server" "skedda_challenge_mssql_server" {
  name                         = "${var.prefix}-mssql-server"
  location                     = azurerm_resource_group.skedda_challenge_resource_group.location
  resource_group_name          = azurerm_resource_group.skedda_challenge_resource_group.name
  version                      = var.azure_mssql_version
  administrator_login          = var.azure_mssql_username
  administrator_login_password = var.azure_mssql_password
  tags                         = var.tags

  azuread_administrator {
    login_username              = var.azuread_administrator["login_username"]
    object_id                   = var.azuread_administrator["object_id"]
    azuread_authentication_only = var.azuread_administrator["azuread_authentication_only"]
  }

}

resource "azurerm_mssql_database" "skedda_challenge_mssql_db" {
  name         = "${var.prefix}-mssql-db"
  server_id    = azurerm_mssql_server.skedda_challenge_mssql_server.id
  license_type = var.azure_mssql_license_type
  max_size_gb  = var.azure_mssql_size
  sku_name     = "S0"

  tags = {
    app    = "aspnetcoreapp"
    region = var.location
  }
}