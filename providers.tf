terraform{
  required_version = "~> 0.14.7"
}
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
  version                = "=2.0.2"
}

provider "helm" {
  kubernetes {
    host = module.aks.aks_kube_config.host

    client_certificate     = base64decode(module.aks.aks_kube_config.client_certificate)
    client_key             = base64decode(module.aks.aks_kube_config.client_key)
    cluster_ca_certificate = base64decode(module.aks.aks_kube_config.cluster_ca_certificate)
    config_path = "~/.kube/config"

  }

   version                = "=2.0.2"
}

provider "datadog" {
  source  = "datadog/datadog"
  version = "~> 2.22.0"
}


