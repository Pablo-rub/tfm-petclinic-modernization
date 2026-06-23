output "acr_login_server" {
  value = module.acr.login_server
}

output "aks_cluster_name" {
  value = var.cluster_name
}

output "resource_group_name" {
  value = var.resource_group_name
}
