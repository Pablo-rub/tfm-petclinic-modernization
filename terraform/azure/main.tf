terraform {
  required_version = ">= 1.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "petclinic-tfstate-rg"
    storage_account_name = "petclinictfstate"
    container_name       = "tfstate"
    key                  = "azure/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

module "acr" {
  source              = "./modules/acr"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  acr_name            = var.acr_name
}

module "aks" {
  source              = "./modules/aks"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  cluster_name        = var.cluster_name
  node_count          = var.node_count
  node_vm_size        = var.node_vm_size
  acr_id              = module.acr.acr_id
}
