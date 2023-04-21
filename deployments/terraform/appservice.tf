resource "azurerm_resource_group" "skedda_challenge_resource_group" {
  name     = "${var.prefix}-rg"
  location = "West Europe"
}

resource "azurerm_app_service_plan" "skedda_challenge_app_service_plan" {
  name                = "${var.prefix}-appserviceplan"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "skedda_challenge_app_service" {
  name                = "${var.prefix}-app-service"
  location            = azurerm_resource_group.skedda_challenge_resource_group.location
  resource_group_name = azurerm_resource_group.skedda_challenge_resource_group.name
  app_service_plan_id = azurerm_app_service_plan.skedda_challenge_app_service_plan.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  }
}

