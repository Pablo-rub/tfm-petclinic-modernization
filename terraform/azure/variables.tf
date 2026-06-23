variable "location" {
  default = "westeurope"
}

variable "resource_group_name" {
  default = "petclinic-rg"
}

variable "cluster_name" {
  default = "petclinic-aks"
}

variable "acr_name" {
  default = "petclinicacr"
}

variable "node_count" {
  default = 2
}

variable "node_vm_size" {
  default = "Standard_D2s_v3"
}
