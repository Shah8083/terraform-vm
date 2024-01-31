provider   "azurerm"   {
 features   {}
 }
resource   "azurerm_resource_group""Test-RG"  {
   name   =   "test-rg"
   location   =   "eastus"
 }
 
 resource   "azurerm_virtual_network"   "Testvnet"   {
   name   =   "test-vnet"
   address_space   =   [ "10.0.0.0/16" ]
   location   =   "eastus"
   resource_group_name   =   azurerm_resource_group.Test-RG.name
 }
 
 resource   "azurerm_subnet"   "Testsubnet"   {
   name   =   "test-Subnet"
   resource_group_name   =    azurerm_resource_group.Test-RG.name
   virtual_network_name   =   azurerm_virtual_network.Testvnet.name
   address_prefixes   =   [ "10.0.1.0/24" ]
 }
 
 resource   "azurerm_public_ip"   "Test-publicip"   {
   name   =   "pip-2"
   location   =   "eastus"
   resource_group_name   =   azurerm_resource_group.Test-RG.name
   allocation_method   =   "Dynamic"
   sku   =   "Basic"
 }
 
 resource   "azurerm_network_interface"   "my-ANI"   {
   name   =   "myvm-ANI"
   location   =   "eastus"
   resource_group_name   =   azurerm_resource_group.Test-RG.name
 
   ip_configuration   {
     name   =   "ipconfig1-s1"
     subnet_id   =   azurerm_subnet.Testsubnet.id
     private_ip_address_allocation   =   "Dynamic"
     public_ip_address_id   =   azurerm_public_ip.Test-publicip.id
   }
 }
 
 resource   "azurerm_windows_virtual_machine"   "test-vm1"   {
   name                    =   "mytestvm"  
   location                =   "eastus"
   resource_group_name     =   azurerm_resource_group.Test-RG.name
   network_interface_ids   =   [ azurerm_network_interface.my-ANI.id ]
   size                    =   "Standard_B1s"
   admin_username          =   "adminuser"
   admin_password          =   "Password123!"
 
   source_image_reference   {
     publisher   =   "MicrosoftWindowsServer"
     offer       =   "WindowsServer"
     sku         =   "2019-Datacenter"
     version     =   "latest"
   }
 
   os_disk   {
     caching             =   "ReadWrite"
     storage_account_type   =   "Standard_LRS"
   }
 }