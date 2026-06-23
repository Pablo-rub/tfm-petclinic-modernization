resource "aws_ecr_repository" "petclinic" {
  name                 = "petclinic"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "vets_service" {
  name                 = "vets-service"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "petclinic" {
  repository = aws_ecr_repository.petclinic.name
  policy = jsonencode({
    rules = [{
      rulePriority = 1
      description  = "Mantener las ultimas 10 imagenes"
      selection = {
        tagStatus   = "any"
        countType   = "imageCountMoreThan"
        countNumber = 10
      }
      action = { type = "expire" }
    }]
  })
}

resource "aws_ecr_lifecycle_policy" "vets_service" {
  repository = aws_ecr_repository.vets_service.name
  policy = jsonencode({
    rules = [{
      rulePriority = 1
      description  = "Mantener las ultimas 10 imagenes"
      selection = {
        tagStatus   = "any"
        countType   = "imageCountMoreThan"
        countNumber = 10
      }
      action = { type = "expire" }
    }]
  })
}
