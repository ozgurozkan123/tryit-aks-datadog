variable "spec" {
  type = object({
    namespace = string
    api_key   = string
    app_key   = string
  })
}