variable "aws_region" {
  default = "eu-west-1"
}

variable "cluster_name" {
  default = "petclinic-eks"
}

variable "cluster_version" {
  default = "1.32"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "node_instance_type" {
  default = "t3.medium"
}

variable "node_desired" {
  default = 2
}

variable "node_min" {
  default = 1
}

variable "node_max" {
  default = 3
}
