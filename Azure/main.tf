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

  subscription_id = "195937cc-e3ef-41ef-81fb-2a4bd6a16de1"
  tenant_id       = "f29733f6-4084-4da4-a42b-7afff520baa9"
}

resource "azurerm_resource_group" "TF_rg" {
  name     = "myTF_RG"
  location = var.az_location
}

resource "azurerm_virtual_network" "TF_vnet" {
  name                = "myTF_vnet"
  address_space       = var.azvnet_adrspc
  location            = azurerm_resource_group.TF_rg.location
  resource_group_name = azurerm_resource_group.TF_rg.name
}

resource "azurerm_subnet" "TF_subnet" {
  name                 = "myTF_subnet"
  resource_group_name  = azurerm_resource_group.TF_rg.name
  virtual_network_name = azurerm_virtual_network.TF_vnet.name
  address_prefixes     = var.azsubnet_adrpre
}

resource "azurerm_public_ip" "TF_pubip" {
  name                = "myTF_pubip"
  location            = azurerm_resource_group.TF_rg.location
  resource_group_name = azurerm_resource_group.TF_rg.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_security_group" "TF_nsg" {
  name                = "myTF_nsg"
  location            = azurerm_resource_group.TF_rg.location
  resource_group_name = azurerm_resource_group.TF_rg.name

  security_rule {
    name                       = "myTF_SSHrule"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = var.azports_allow[0]
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "TF_nic" {
  name                = "myTF_nic"
  location            = azurerm_resource_group.TF_rg.location
  resource_group_name = azurerm_resource_group.TF_rg.name

  ip_configuration {
    name                          = "myTF_nic_conf"
    subnet_id                     = azurerm_subnet.TF_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.TF_pubip.id
  }
}

resource "azurerm_network_interface_security_group_association" "TF_nic_nsg" {
  network_interface_id      = azurerm_network_interface.TF_nic.id
  network_security_group_id = azurerm_network_security_group.TF_nsg.id
}

# Create storage account for boot diagnostics logs
resource "azurerm_storage_account" "TF_storage_acct" {
  name                     = var.az_oslogs
  location                 = azurerm_resource_group.TF_rg.location
  resource_group_name      = azurerm_resource_group.TF_rg.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create (and display) an SSH key
resource "tls_private_key" "TF_ssh_privkey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "TF_vm1" {
  name                  = "myTF_VM1"
  location              = azurerm_resource_group.TF_rg.location
  resource_group_name   = azurerm_resource_group.TF_rg.name
  network_interface_ids = [azurerm_network_interface.TF_nic.id]
  size                  = "Standard_DS1_v2"

  os_disk {
    name                 = "myTF_OSDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name                   = var.az_vm
  admin_username                  = var.az_users
  disable_password_authentication = true

  admin_ssh_key {
    username   = "azureuser"
    public_key = tls_private_key.TF_ssh_privkey.public_key_openssh
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.TF_storage_acct.primary_blob_endpoint
  }
}
