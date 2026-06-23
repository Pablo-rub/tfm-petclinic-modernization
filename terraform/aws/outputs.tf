output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_name" {
  value = var.cluster_name
}

output "ecr_petclinic_url" {
  value = module.ecr.petclinic_url
}

output "ecr_vets_url" {
  value = module.ecr.vets_url
}
