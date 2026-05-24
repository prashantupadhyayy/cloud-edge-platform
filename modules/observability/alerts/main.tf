resource "azurerm_monitor_action_group" "this" {
  name                = var.action_group_name
  resource_group_name = var.resource_group_name
  short_name          = var.short_name

  email_receiver {
    name           = "EmailReceiver"
    email_address  = var.alert_email
    use_common_schema = true
  }

  tags = var.common_tags
}

resource "azurerm_monitor_metric_alert" "this" {
  for_each = var.metric_alerts

  name                = each.value.name
  resource_group_name = var.resource_group_name
  scopes              = each.value.scopes
  description         = each.value.description
  severity            = each.value.severity
  enabled             = each.value.enabled

  criteria {
    metric_name      = each.value.metric_name
    metric_namespace = each.value.metric_namespace
    aggregation      = each.value.aggregation
    operator         = each.value.operator
    threshold        = each.value.threshold
  }

  action {
    action_group_id = azurerm_monitor_action_group.this.id
  }
}
