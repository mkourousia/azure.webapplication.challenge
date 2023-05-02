#################################################################################
################################ DR APP SERVICE #################################
#################################################################################

resource "azurerm_service_plan" "skedda_challenge_service_plan" {
  name                = "${var.prefix}-appserviceplan"
  location            = var.location
  resource_group_name = "skedda-challenge-dr-rg"
  os_type             = "Linux"
  sku_name            = "F1"

  tags = var.tags
}

resource "azurerm_linux_web_app" "skedda_challenge_web_app_dr" {
  name                = "${var.prefix}-app-service"
  location            = var.location
  resource_group_name = "skedda-challenge-dr-rg"
  service_plan_id     = azurerm_service_plan.skedda_challenge_service_plan.id

  site_config {
    always_on         = false
    use_32_bit_worker = true

    application_stack {
      dotnet_version = "7.0"
    }
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=tcp:${data.azurerm_mssql_server.secodary_mssql_server.fully_qualified_domain_name};User ID=${var.azure_mssql_username};Password=${var.azure_mssql_password};Trusted_Connection=False;Encrypt=True;"
  }

  app_settings = {
    "DbConnectionString" = "Server=tcp:${data.azurerm_mssql_server.secodary_mssql_server.fully_qualified_domain_name};User ID=${var.azure_mssql_username};Password=${var.azure_mssql_password};Trusted_Connection=False;Encrypt=True;",
    "DetailedErrors"     = true
  }

  tags = var.tags
}

data "azurerm_mssql_server" "secodary_mssql_server" {
  name                = "skedda-challenge-mssql-server-secondary"
  resource_group_name = "skedda-challenge-dr-rg"
}