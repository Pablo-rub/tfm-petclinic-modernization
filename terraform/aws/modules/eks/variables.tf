variable "cluster_name" {}
variable "cluster_version" {}
variable "vpc_id" {}
variable "subnet_ids" { type = list(string) }
variable "node_instance_type" {}
variable "node_desired" {}
variable "node_min" {}
variable "node_max" {}
