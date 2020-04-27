provider "azurerm" {
  version = "=2.7.0"
  features {}
}

provider "kubernetes" {
  host = module.aks.aks_kube_admin_config.host

  client_certificate     = base64encode(module.aks.aks_kube_admin_config.client_certificate)
  client_key             = base64encode(module.aks.aks_kube_admin_config.client_certificate)
  cluster_ca_certificate = base64encode(module.aks.aks_kube_admin_config.cluster_ca_certificate)
  load_config_file       = false
}

provider "helm" {
  kubernetes {
    host = module.aks.aks_kube_admin_config.host

    client_certificate     = base64encode(module.aks.aks_kube_admin_config.client_certificate)
    client_key             = base64encode(module.aks.aks_kube_admin_config.client_certificate)
    cluster_ca_certificate = base64encode(module.aks.aks_kube_admin_config.cluster_ca_certificate)
    load_config_file       = false
  }
}