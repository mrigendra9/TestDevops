resource "azurerm_resource_group" "dev" {
  name = var.resource_group1
  location = "centralindia"
}

resource "azurerm_storage_account" "dev" {
  name = var.storage_account
  resource_group_name = azurerm_resource_group.dev.name
  location  = azurerm_resource_group.dev.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}


resource "azurerm_network_security_group" "dev" {
  name                = var.nsg
  location            = azurerm_resource_group.dev.location
  resource_group_name = azurerm_resource_group.dev.name
}

resource "azurerm_virtual_network" "dev" {
  name = var.vnet
  resource_group_name = azurerm_resource_group.dev.name
  location = azurerm_resource_group.dev.location
  address_space       = ["192.168.2.0/24"]
  #dns_servers         = ["10.1.0.4", "10.1.0.5"]
}

resource "azurerm_subnet" "Dev" {
  name           = var.subnet1
  resource_group_name = azurerm_resource_group.dev.name
  #security_group = azurerm_network_security_group.dev.id
  virtual_network_name = azurerm_virtual_network.dev.name
  address_prefixes     = ["192.168.2.0/27"]
}

resource "azurerm_subnet" "Dev1" {
  name           = var.subnet2
  resource_group_name = azurerm_resource_group.dev.name
  virtual_network_name = azurerm_virtual_network.dev.name 
  address_prefixes     = ["192.168.2.32/28"] 
}


resource "azurerm_network_interface" "dev" {
  name                = var.nic
  location            = azurerm_resource_group.dev.location
  resource_group_name = azurerm_resource_group.dev.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.Dev.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "dev" {
  name                = var.vm_name
  resource_group_name = azurerm_resource_group.dev.name
  location            = azurerm_resource_group.dev.location
  size                = "Standard_B1s"
  admin_username      = var.vm_username
  admin_password      = var.vm_password
  network_interface_ids = [
    azurerm_network_interface.dev.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}
