resource "azurerm_resource_group" "skedda_challenge_resource_group" {
  name     = "${var.prefix}-rg"
  location = var.location
}

resource "azurerm_service_plan" "skedda_challenge_service_plan" {
  name                = "${var.prefix}-appserviceplan"
  location            = azurerm_resource_group.skedda_challenge_resource_group.location
  resource_group_name = azurerm_resource_group.skedda_challenge_resource_group.name
  os_type             = "Linux"
  sku_name            = "B1"

  tags = var.tags
}

resource "azurerm_linux_web_app" "skedda_challenge_web_app" {
  name                = "${var.prefix}-app-service"
  location            = azurerm_resource_group.skedda_challenge_resource_group.location
  resource_group_name = azurerm_resource_group.skedda_challenge_resource_group.name
  service_plan_id     = azurerm_service_plan.skedda_challenge_service_plan.id

  site_config {
    always_on = false

    application_stack {
      dotnet_version = "7.0"
    }
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=tcp:${azurerm_mssql_server.skedda_challenge_mssql_server.name}.database.windows.net;User ID=${var.azure_mssql_username};Password=${random_password.mssql_password.result};Trusted_Connection=False;Encrypt=True;"
  }

  app_settings = {
    "DbConnectionString" = "Server=tcp:${azurerm_mssql_server.skedda_challenge_mssql_server.name}.database.windows.net;User ID=${var.azure_mssql_username};Password=${random_password.mssql_password.result};Trusted_Connection=False;Encrypt=True;",
    "DetailedErrors"     = true
  }

  tags = var.tags
}

#################################################################################
############################# FAILOVER MSSQL SERVER #############################
#################################################################################

resource "azurerm_linux_web_app" "skedda_challenge_web_app_dr" {
  count               = var.deploy_dr_appService ? 1 : 0
  name                = "${var.prefix}-app-service"
  location            = azurerm_resource_group.skedda_challenge_resource_group_dr.location
  resource_group_name = azurerm_resource_group.skedda_challenge_resource_group_dr.name
  service_plan_id     = azurerm_service_plan.skedda_challenge_service_plan.id

  site_config {
    always_on = false

    application_stack {
      dotnet_version = "7.0"
    }
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=tcp:${azurerm_mssql_server.skedda_challenge_mssql_server_secondary.name}.database.windows.net;User ID=${var.azure_mssql_username};Password=${random_password.mssql_password.result};Trusted_Connection=False;Encrypt=True;"
  }

  app_settings = {
    "DbConnectionString" = "Server=tcp:${azurerm_mssql_server.skedda_challenge_mssql_server_secondary.name}.database.windows.net;User ID=${var.azure_mssql_username};Password=${random_password.mssql_password.result};Trusted_Connection=False;Encrypt=True;",
    "DetailedErrors"     = true
  }

  tags = var.tags
}
