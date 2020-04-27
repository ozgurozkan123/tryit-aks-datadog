resource "azurerm_kubernetes_cluster" "aks_datadog" {
  dns_prefix          = var.aks_spec.dns_prefix
  location            = var.resource_group.location
  name                = var.aks_spec.name
  resource_group_name = var.resource_group.name

  default_node_pool {
    name       = var.aks_spec.default_node_pool.name
    node_count = var.aks_spec.default_node_pool.node_count
    vm_size    = var.aks_spec.default_node_pool.vm_size
  }

  service_principal {
    client_id     = var.service_principal.client_id
    client_secret = var.service_principal.client_secret
  }

  tags = {
    ENV = "TEST"
  }
}