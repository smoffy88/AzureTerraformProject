# Create a Public IP for the Jumpbox
resource "azurerm_public_ip" "jmp_pip" {
  name                = "jmp-pip"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Static"
  tags                = var.tags
}

# Network Interface for Jumpbox
resource "azurerm_network_interface" "jmp_nic" {
  name                = "jmp1-nic"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tags                = var.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.jmp_snet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.jmp_pip.id
  }
}

# The Jumpbox VM
resource "azurerm_windows_virtual_machine" "jmp" {
  name                = "jmp1"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  size                = var.vm_sizes["jumpbox"]
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  tags                = var.tags
  network_interface_ids = [
    azurerm_network_interface.jmp_nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
}
