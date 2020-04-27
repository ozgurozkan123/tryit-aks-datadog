resource "azurerm_resource_group" "resource_group" {
  location = "South Central US"
  name     = "rg-aks-datadog"

  tags = {
    ENV = "TEST"
  }
}

module "aks" {
  source         = "./aks"
  resource_group = azurerm_resource_group.resource_group
  aks_spec = {
    name               = "Aks-Earth"
    dns_prefix         = "aks-earth"
    kubernetes_version = "1.15.10"
    default_node_pool = {
      name       = "default"
      node_count = 3
      vm_size    = "Standard_D2_V2"
    }
  }
  service_principal = {
    client_id     = var.service_principal_client_id
    client_secret = var.service_principal_client_secret
  }
}

resource "kubernetes_namespace" "datadog" {
  metadata {
    name = "datadog"
  }
}

module "datadog-agent" {
  source = "./datadog"
  spec = {
    namespace = kubernetes_namespace.datadog.metadata.0.name
    api_key   = var.datadog_api_key
    app_key   = var.datadog_app_key
  }
}

terraform {
  backend "azurerm" {}
}