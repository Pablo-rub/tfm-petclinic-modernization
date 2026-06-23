output "petclinic_url" {
  value = aws_ecr_repository.petclinic.repository_url
}

output "vets_url" {
  value = aws_ecr_repository.vets_service.repository_url
}
