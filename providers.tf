terraform {

  required_providers {

    datadog = {
      source  = "datadog/datadog"
      version = "~> 2.22.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0.2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0.2"
    }
  }


  required_version = "~> 0.14.7"
}
provider azurerm {
  features {}
}
