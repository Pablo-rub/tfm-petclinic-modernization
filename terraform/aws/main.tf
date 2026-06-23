terraform {
  required_version = ">= 1.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket         = "tfm-petclinic-tfstate-012699770554"
    key            = "aws/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "tfm-petclinic-tfstate-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source       = "./modules/vpc"
  cluster_name = var.cluster_name
  vpc_cidr     = var.vpc_cidr
}

module "ecr" {
  source = "./modules/ecr"
}

module "eks" {
  source          = "./modules/eks"
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnet_ids
  node_instance_type = var.node_instance_type
  node_desired    = var.node_desired
  node_min        = var.node_min
  node_max        = var.node_max
}

module "iam" {
  source       = "./modules/iam"
  cluster_name = var.cluster_name
  oidc_url     = module.eks.oidc_url
  oidc_arn     = module.eks.oidc_arn
}
