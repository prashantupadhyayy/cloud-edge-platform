output "id" {
  description = "ID of the AKS cluster"
  value       = azurerm_kubernetes_cluster.this.id
}

output "name" {
  description = "Name of the AKS cluster"
  value       = azurerm_kubernetes_cluster.this.name
}

output "kube_config" {
  description = "Kubernetes config"
  value       = azurerm_kubernetes_cluster.this.kube_config_raw
  sensitive   = true
}

output "fqdn" {
  description = "FQDN of the cluster"
  value       = azurerm_kubernetes_cluster.this.fqdn
}
