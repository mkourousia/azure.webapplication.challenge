resource "azurerm_monitor_metric_alert" "skedda_challenge_monitor_metric_alert" {
  name                = "${var.prefix}-metricalert"
  resource_group_name = "skedda-challenge-dr-rg"
  scopes              = [azurerm_linux_web_app.skedda_challenge_web_app_dr.id]
  description         = "Action will be triggered when requests count is greater than 20."

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "Requests"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 20
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.general_monitor_action_group.id
  }
}

data "azurerm_monitor_action_group" "general_monitor_action_group" {
  resource_group_name = "action-groups-rg"
  name                = "mkourousiaActionGroup"
}