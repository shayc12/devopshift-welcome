provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg-shay" {
  name     = "shay-resources"
  location = var.location
}

resource "azurerm_virtual_network" "vnet-shay" {
  name                = "shay-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.rg-shay.name
}

resource "azurerm_subnet" "subnet-shay" {
  name                 = "shay-subnet"
  resource_group_name  = azurerm_resource_group.rg-shay.name
  virtual_network_name = azurerm_virtual_network.vnet-shay.name
  address_prefixes     = ["10.0.1.0/24"]
}



module "vm1" {
    source = "./module/vm"
    rg = azurerm_resource_group.rg-shay.name
    location = azurerm_resource_group.rg-shay.location
  
}

module "vm2" {
    source = "./module/vm"
    rg = azurerm_resource_group.rg-shay.name
    location = azurerm_resource_group.rg-shay.location
  
}