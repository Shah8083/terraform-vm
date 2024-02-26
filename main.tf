#Define the provider
provider   "azurerm"   {
 
features   {}
 }

 # Specify location to store tfstate files
terraform {
  backend "azurerm" {
    resource_group_name  = "ShaReleaseRG"
    storage_account_name = "sharelease"
    container_name       = "shareleasedemo"
    key                  = "$(storageaccountkey)"
  }
}

# Define the resource group
resource "azurerm_resource_group" "RG1" {
  name     = var.rg
  location = var.rg_location
}
 
# Define the virtual network
resource "azurerm_virtual_network" "MYVNET" {
  name                = var.azurerm_virtual_network
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.RG1.location
  resource_group_name = azurerm_resource_group.RG1.name
}
 
# Define the subnets
resource "azurerm_subnet" "MYwindows10" {
  name                 = var.azurerm_subnet
  resource_group_name  = azurerm_resource_group.RG1.name
  virtual_network_name = azurerm_virtual_network.MYVNET.name
  address_prefixes     = ["10.0.1.0/24"]
}
 
# Define the public IP addresses
resource "azurerm_public_ip" "MYwindows10" {
  name                = var.azurerm_public_ip
  location            = azurerm_resource_group.RG1.location
  resource_group_name = azurerm_resource_group.RG1.name
  allocation_method   = var.allocation_method
}
 
 # Define the network interfaces
resource "azurerm_network_interface" "MYwindows10" {
  name                = var.azurerm_virtual_network
  location            = azurerm_resource_group.RG1.location
  resource_group_name = azurerm_resource_group.RG1.name
 
  ip_configuration {
    name                          = var.ip_configuration
    subnet_id                     = azurerm_subnet.MYwindows10.id
    public_ip_address_id          = azurerm_public_ip.MYwindows10.id
    private_ip_address_allocation = var.private_ip_address_allocation
  }
}
 
# Define the virtual machines
resource "azurerm_windows_virtual_machine" "MYwindows10" {
  name                  = var.azurerm_virtual_machine
  location              = azurerm_resource_group.RG1.location
  resource_group_name   = azurerm_resource_group.RG1.name
  network_interface_ids = [azurerm_network_interface.MYwindows10.id]
  size                  = var.size
  admin_username        = var.admin_username  
  admin_password        = var.admin_password
  os_disk {
    name              = var.os_disk-name
    caching           = var.caching
    storage_account_type = var.storage_account_type
  }
  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "windows-10"
    sku       = "win10-21h2-avd"
    version   = "latest"
  }
}