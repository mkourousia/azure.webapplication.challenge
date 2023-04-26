resource "azurerm_resource_group" "skedda_challenge_resource_group" {
  name     = "${var.prefix}-rg"
  location = var.location
}

resource "azurerm_service_plan" "skedda_challenge_service_plan" {
  name                = "${var.prefix}-appserviceplan"
  location            = azurerm_resource_group.skedda_challenge_resource_group.location
  resource_group_name = azurerm_resource_group.skedda_challenge_resource_group.name
  os_type             = "Linux"
  sku_name            = "F1"

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
    value = "Server=skedda-challenge-mssql-server.database.windows.net;Integrated Security=SSPI"
  }

  tags = var.tags
}

