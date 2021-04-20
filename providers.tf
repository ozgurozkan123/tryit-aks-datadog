provider "azurerm" {
  version = "=2.7.0"
  features {}
}

provider "kubernetes" {
  host = module.aks.aks_kube_config.host

  client_certificate     = base64decode(module.aks.aks_kube_config.client_certificate)
  client_key             = base64decode(module.aks.aks_kube_config.client_key)
  cluster_ca_certificate = base64decode(module.aks.aks_kube_config.cluster_ca_certificate)
  load_config_file       = false
  version                = "=1.10.0"
}

provider "helm" {
  kubernetes {
    host = module.aks.aks_kube_config.host

    client_certificate     = base64decode(module.aks.aks_kube_config.client_certificate)
    client_key             = base64decode(module.aks.aks_kube_config.client_key)
    cluster_ca_certificate = base64decode(module.aks.aks_kube_config.cluster_ca_certificate)
   version                = "=1.3.2"
   load_config_file = false 
  }
}
