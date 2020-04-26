variable "resource_group" {
  type = object({
    location = string
    name     = string
  })
}

variable "aks_spec" {
  type = object({
    name               = string
    dns_prefix         = string
    kubernetes_version = string

    default_node_pool = object({
      name       = string
      node_count = string
      vm_size    = string
    })
  })
}

variable "service_principal" {
  type = object({
    client_id     = string
    client_secret = string
  })
}