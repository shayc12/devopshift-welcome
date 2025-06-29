
resource "azurerm_public_ip" "pip-shay" {
  name                = "shay-pip"
  location            = var.location
  resource_group_name = var.rg
  allocation_method   = "Dynamic"  # Dynamic IP allocation for Basic SKU
  sku = "Basic"  
}

resource "azurerm_network_interface" "nic-shay" {
  name                = "shay-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg-shay.name

  ip_configuration {
    name                          = "shay-ipconfig"
    subnet_id                     = azurerm_subnet.subnet-shay.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip-shay.id
  }
}

resource "azurerm_linux_virtual_machine" "vm-shay" {
  name                  = "shay-vm"
  location              = var.location
  resource_group_name   = azurerm_resource_group.rg-shay.name
  network_interface_ids = [azurerm_network_interface.nic-shay.id]
  size                  = var.vm_size

  os_disk {
    name              = "shay-os-disk"
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  admin_username = var.admin_username
  admin_password = var.admin_password

  disable_password_authentication = false

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name = "shay-vm"
}

resource "time_sleep" "wait_for_ip" {
  create_duration = "30s"  # Introduce a delay of 30 seconds
}
