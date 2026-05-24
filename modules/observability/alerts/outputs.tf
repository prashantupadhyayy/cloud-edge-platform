output "action_group_id" {
  description = "ID of the action group"
  value       = azurerm_monitor_action_group.this.id
}

output "alert_ids" {
  description = "IDs of the metric alerts"
  value       = { for k, v in azurerm_monitor_metric_alert.this : k => v.id }
}
