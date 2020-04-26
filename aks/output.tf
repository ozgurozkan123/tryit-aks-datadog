output "kube_admin_config" {
  value = azurerm_kubernetes_cluster.aks_datadog.kube_admin_config.0
}