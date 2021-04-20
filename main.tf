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
    kubernetes_version = "1.18.14"
    default_node_pool = {
      name       = "default"
      node_count = 2
      vm_size    = "Standard_D1_v2"
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
resource "kubernetes_deployment" "datadog" {
  metadata {
    name      = "datadog-app"
    namespace = kubernetes_namespace.datadog.id
    labels = {
      app = "datadog-app"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "datadog-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "datadog-app"
        }
      }

      spec {
        container {
          image = "onlydole/beacon:datadog"
          name  = "datadog-app"
        }
      }
    }
  }
}

resource "kubernetes_service" "beacon" {
  metadata {
    name      = "datadog-app"
    namespace = kubernetes_namespace.datadog.id
  }
  spec {
    selector = {
      app = kubernetes_deployment.datadog.metadata[0].labels.app
    }
    port {
      node_port   = 30201
      port        = 8080
      target_port = 80
    }
    type = "NodePort"
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
