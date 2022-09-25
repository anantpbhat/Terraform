# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.azrg_name
  location = "westus2"
}

output "rg_location" {
value = azurerm_resource_group.rg.location
}

output "vnet_addrspace" {
value = azurerm_virtual_network.vnet.address_space[0]
}
