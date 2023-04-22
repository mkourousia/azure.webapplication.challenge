resource "azurerm_resource_group" "skedda_challenge_resource_group" {
  name     = "${var.prefix}-rg"
  location = var.location
}

resource "azurerm_app_service_plan" "skedda_challenge_app_service_plan" {
  name                = "${var.prefix}-appserviceplan"
  location            = azurerm_resource_group.skedda_challenge_resource_group.location
  resource_group_name = azurerm_resource_group.skedda_challenge_resource_group.name

  sku {
    tier = "Free"
    size = "F1"
  }

  tags = var.tags
}

resource "azurerm_app_service" "skedda_challenge_app_service" {
  name                = "${var.prefix}-app-service"
  location            = azurerm_resource_group.skedda_challenge_resource_group.location
  resource_group_name = azurerm_resource_group.skedda_challenge_resource_group.name
  app_service_plan_id = azurerm_app_service_plan.skedda_challenge_app_service_plan.id

  site_config {
    dotnet_framework_version  = "v6.0"
    scm_type                  = "LocalGit"
    use_32_bit_worker_process = true
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  }

  tags = var.tags
}

