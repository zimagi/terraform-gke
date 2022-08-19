locals {
  helm_charts = {
    argocd = {
      name       = lookup(var.argocd_chart, "name", "argo-cd")
      chart      = lookup(var.argocd_chart, "chart", "argo-cd")
      repository = lookup(var.argocd_chart, "repository", "https://argoproj.github.io/argo-helm")
      version    = lookup(var.argocd_chart, "version", "4.10.6")
      values = lookup(var.argocd_chart, "values", tolist(["${file("${path.module}/helm/argocd_values.yaml")}", "${file("${path.root}/helm/argocd_values.yaml")}"]))
      namespace = lookup(var.argocd_chart, "namespace", "argo-cd")
      create_namespace = lookup(var.argocd_chart, "create_namespace", true)
    }
    argocd_apps = {
      name       = lookup(var.argocd_apps_chart, "name", "argocd-apps")
      chart      = lookup(var.argocd_apps_chart, "chart", "argocd-apps")
      repository = lookup(var.argocd_apps_chart, "repository", "https://charts.zimagi.com")
      version    = lookup(var.argocd_apps_chart, "version", "1.0.3")
      values = lookup(var.argocd_apps_chart, "values", tolist(["${file("${path.module}/helm/argocd_apps_values.yaml")}"]))
      namespace = lookup(var.argocd_apps_chart, "namespace", "argo-cd")
      create_namespace = lookup(var.argocd_apps_chart, "create_namespace", true)
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
  namespace = each.value.namespace
  repository       = each.value.repository
  values           = each.value.values
  create_namespace = each.value.create_namespace
}