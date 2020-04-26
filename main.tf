resource "azurerm_resource_group" "resource-group" {
  location = "South Central US"
  name = "rg-aks-datadog"
}

terraform {
  backend "azurerm" {}
}