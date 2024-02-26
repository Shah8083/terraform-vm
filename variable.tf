variable "rg" {
    type = string
    description = "resource group name"
    default = "Test-RG1"
  
}

variable "rg_location" {
    type = string
    description = "resource location"
    default = "eastus"
  
}

variable "azurerm_virtual_network" {
    type = string
    description = "vnet name"
    default = "MYVNET"
  
}

variable "azurerm_subnet" {
    type = string
    description = "subnet name"
    default = "MYwindows10-subnet"
  
}

variable "azurerm_public_ip" {
    type = string
    description = "public-ip name"
    default = "MYwindows10-public-ip"
  
}

variable "allocation_method" {
    type = string
    description = "hide dynamic name"
    default = "Dynamic"
  
}

variable "azurerm_network_interface" {
    type = string
    description = "hide ANI NAME"
    default = "MYwindows10-nic"
  
}

variable "ip_configuration" {
    type = string
    description = " ip configuration name"
    default = "mywindows10-ip-config"
  
}

variable "private_ip_address_allocation" {
    type = string
    description = "private ip name"
    default = "Dynamic"
  
}


variable "azurerm_virtual_machine" {
    type = string
    description = "vm name"
    default = "MYwindows10-vm"
  
}

variable "size" {
    type = string
    description = "Standard_DS1_v2"
    default = "Standard_DS1_v2"
  
}

variable "admin_username" {
    type = string
    description = "admin_username "
    default = "Ismile-Training"
  
}

variable "admin_password" {
    type = string
    description = "admin_password"
    default = "P@ssw0rd12345!"
  
}

variable "os_disk-name" {
    type = string
    description = "os_disk name"
    default = "windows10-os-disk"
  
}

variable "caching" {
    type = string
    description = "ReadWrite"
    default = "ReadWrite"
  
}

variable "storage_account_type" {
    type = string
    description = "storage_account_type"
    default = "Standard_LRS"
  
}