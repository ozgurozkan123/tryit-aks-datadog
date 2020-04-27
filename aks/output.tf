output "aks_kube_config" {
  value = azurerm_kubernetes_cluster.aks_datadog.kube_config.0
}