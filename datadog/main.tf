data "helm_repository" "stable" {
  name = "stable"
  url  = "https://kubernetes-charts.storage.googleapis.com"
}

resource "helm_release" "datadog-agent" {
  chart      = "datadog"
  name       = "datadog-agent"
  repository = data.helm_repository.stable.metadata.0.name
  namespace  = var.spec.namespace

  set {
    name  = "datadog.apiKey"
    value = var.spec.api_key
  }

  set {
    name  = "datadog.appKey"
    value = var.spec.app_key
  }

  values = [
    file("${abspath(path.module)}/datadog-values.yaml")
  ]

  force_update = true
}