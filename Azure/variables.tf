variable "az_location" {
  description = "Value of the name for the Azure RG"
  # basic types include string, number and bool
  type    = string
  default = "eastus"
}

variable "azvnet_adrspc" {
  description = "Value for Azure vnet address space"
  # basic types include string, number and bool
  type    = list(any)
  default = ["10.10.0.0/16"]
}

variable "azsubnet_adrpre" {
  description = "Value for Azure Subnet address prefix"
  # basic types include string, number and bool
  type    = list(any)
  default = ["10.10.5.0/24"]
}

variable "azports_allow" {
  description = "Value for Inbound allow ports"
  # basic types include string, number and bool
  type    = list(any)
  default = ["22"]
}

variable "az_vm" {
  description = "Value for Azure VM name"
  # basic types include string, number and bool
  type    = string
  default = "mytfvm1"
}

variable "az_users" {
  description = "Value for Azure users"
  # basic types include string, number and bool
  type    = string
  default = "azureuser"
}
