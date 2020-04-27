provider "azurerm" {
  version = "=2.7.0"
  features {}
}

provider "kubernetes" {
  host = module.aks.kube_admin_config.host

  client_certificate     = base64encode(module.aks.kube_admin_config.client_certificate)
  client_key             = base64encode(module.aks.kube_admin_config.client_certificate)
  cluster_ca_certificate = base64encode(module.aks.kube_admin_config.cluster_ca_certificate)
  load_config_file       = false
}

provider "helm" {
  kubernetes {
    host = module.aks.kube_admin_config.host

    client_certificate     = base64encode(module.aks.kube_admin_config.client_certificate)
    client_key             = base64encode(module.aks.kube_admin_config.client_certificate)
    cluster_ca_certificate = base64encode(module.aks.kube_admin_config.cluster_ca_certificate)
    load_config_file       = false
  }
}

data "helm_repository" "stable" {
  name = "stable"
  url  = "https://kubernetes-charts.storage.googleapis.com"
}