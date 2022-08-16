locals {
  helm_charts = {
    argocd = {
      name       = "argo-cd"
      chart      = "zimagi"
      repository = "https://argoproj.github.io/argo-helm"
      version    = "4.10.6"
      values = [
        "${file("${path.module}/helm/argocd_values.yaml")}"
      ]
      create_namespace = true
    }
    argocd_apps = {
      name       = "argocd-apps"
      chart      = "argocd-apps"
      repository = "https://charts.zimagi.com"
      version    = "1.0.3"
      values = [
        "${file("${path.module}/helm/argocd_apps_values.yaml")}"
      ]
      create_namespace = true
    }
  }
}

resource "helm_release" "this" {
  for_each = local.helm_charts
  depends_on = [
    module.gke
  ]
  name             = each.value.name
  chart            = each.value.chart
  repository       = each.value.repository
  values           = each.value.values
  create_namespace = each.value.create_namespace
}