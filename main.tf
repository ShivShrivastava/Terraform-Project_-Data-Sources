# Data Sources for existing Resource Group
data "azurerm_resource_group" "shared-rg" {
  name = "shared-network-rg"
}

# Data Sources for existing Virtual Network
data "azurerm_virtual_network" "shared-vnet" {
  name                = "share-vnet"
  resource_group_name = data.azurerm_resource_group.shared-rg.name
}

# Data Sources for existing Subnet
data "azurerm_subnet" "shared-subnet" {
  name                 = "shared-subnet"
  resource_group_name  = data.azurerm_resource_group.shared-rg.name
  virtual_network_name = data.azurerm_virtual_network.shared-vnet.name
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-rg"
  location = data.azurerm_resource_group.shared-rg.location
}

resource "azurerm_network_interface" "nic" {
  name                = "${var.prefix}-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = data.azurerm_subnet.shared-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "vm" {
  name                  = "${var.prefix}-vmshared"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic.id]
  vm_size               = "Standard_B1s"
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

#Use: terraform apply -var="computer_name=shivvm" -var="admin_username=testadmin" -var="admin_password=Password1234!"
#Use: terraform apply -var-file="variables.tfvars"

  os_profile {
    computer_name  = var.computer_name
    admin_username = var.admin_username
    admin_password = var.admin_password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}