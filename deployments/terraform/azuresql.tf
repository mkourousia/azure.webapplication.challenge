resource "azurerm_mssql_server" "skedda_challenge_mssql_server" {
  name                         = "${var.prefix}-mssql-server"
  location                     = azurerm_resource_group.skedda_challenge_resource_group.location
  resource_group_name          = azurerm_resource_group.skedda_challenge_resource_group.name
  version                      = var.azure_mssql_version
  administrator_login          = var.azure_mssql_username
  administrator_login_password = random_password.mssql_password.result
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

resource "azurerm_mssql_firewall_rule" "example" {
  name             = "AppServiceAllow"
  server_id        = azurerm_mssql_server.skedda_challenge_mssql_server.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "255.255.255.255"
}

resource "random_password" "mssql_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

### FAILOVER MSSQL SERVER ###

resource "azurerm_mssql_server" "skedda_challenge_mssql_server_secondary" {
  name                         = "${var.prefix}-mssql-server-secondary"
  location                     = var.secondary_location
  resource_group_name          = azurerm_resource_group.skedda_challenge_resource_group.name
  version                      = var.azure_mssql_version
  administrator_login          = var.azure_mssql_username
  administrator_login_password = random_password.mssql_password.result

  tags = var.tags

  azuread_administrator {
    login_username              = var.azuread_administrator["login_username"]
    object_id                   = var.azuread_administrator["object_id"]
    azuread_authentication_only = var.azuread_administrator["azuread_authentication_only"]
  }
}


resource "azurerm_mssql_failover_group" "skedda_challenge_failover_group" {
  name      = "${var.prefix}-failover-group"
  server_id = azurerm_mssql_server.skedda_challenge_mssql_server.id
  databases = [
    azurerm_mssql_database.skedda_challenge_mssql_db.id
  ]

  partner_server {
    id = azurerm_mssql_server.skedda_challenge_mssql_server_secondary.id
  }

  read_write_endpoint_failover_policy {
    mode          = "Automatic"
    grace_minutes = 80
  }

  tags = var.tags
}