terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.16.0"
    }
  }
  required_version = ">=1.2.5"
}

provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "hack-rg" {
  name = var.hack-rg
}

# Locate the existing custom image
data "azurerm_image" "main" {
  name                = "myPackerVMImage"
  resource_group_name = var.hack-rg
}

resource "azurerm_storage_account" "stor" {
  name                     = "hackstor1"
  location                 = var.location
  resource_group_name      = var.hack-rg
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_replication_type
  tags = {
    environment = "dev"
  }
}

resource "azurerm_availability_set" "avset" {
  name                         = "hack-avset"
  location                     = var.location
  resource_group_name          = var.hack-rg
  platform_fault_domain_count  = var.count_on
  platform_update_domain_count = var.count_on
  managed                      = true
  tags = {
    environment = "dev"
  }
}

resource "azurerm_virtual_network" "hack-vnet" {
  name                = "hack-vnet"
  location            = var.location
  address_space       = ["${var.address_space}"]
  resource_group_name = var.hack-rg

  tags = {
    environment = "dev"
  }
}

resource "azurerm_subnet" "hack-subnet" {
  name                 = "hack-subnet"
  resource_group_name  = var.hack-rg
  virtual_network_name = azurerm_virtual_network.hack-vnet.name
  address_prefixes     = ["${var.subnet_prefix}"]
}

resource "azurerm_network_security_group" "hack-nsg" {
  name                = "hack-nsg"
  location            = var.location
  resource_group_name = var.hack-rg

  tags = {
    environment = "dev"
  }
}

resource "azurerm_network_security_rule" "hack-nsr-dev-rules" {
  for_each                    = locals.nsgrules 
  name                        = each.key
  direction                   = each.value.direction
  access                      = each.value.access
  priority                    = each.value.priority
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = var.hack-rg
  network_security_group_name = azurerm_network_security_group.hack-nsg.name
}

resource "azurerm_subnet_network_security_group_association" "hack-nsga" {
  subnet_id                 = azurerm_subnet.hack-subnet.id
  network_security_group_id = azurerm_network_security_group.hack-nsg.id
}

resource "azurerm_public_ip" "hack-pub-ip" {
  name                = "hack-pub-ip"
  resource_group_name = var.hack-rg
  location            = var.location
  allocation_method   = "Dynamic"
  domain_name_label   = "hack-dns-1"
  tags = {
    environment = "dev"
  }
}

resource "azurerm_network_interface" "hack-nic" {
  name                = "internal-${count.index}"
  location            = var.location
  resource_group_name = var.hack-rg
  count               = var.count_on
  ip_configuration {
    name                          = "internal-${count.index}"
    subnet_id                     = azurerm_subnet.hack-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
  tags = {
    environment = "dev"
  }
}

resource "azurerm_lb_nat_rule" "hack-natrule" {
  resource_group_name            = var.hack-rg
  loadbalancer_id                = azurerm_lb.hack-lb.id
  name                           = "RDP-VM-${count.index}"
  protocol                       = "Tcp"
  frontend_port                  = "5000${count.index + 1}"
  backend_port                   = 3389
  frontend_ip_configuration_name = "LoadBalancerFrontEnd"
  count                          = var.count_on
}

resource "azurerm_network_interface_backend_address_pool_association" "hack-addpool" {
  count                   = var.count_on
  network_interface_id    = element(azurerm_network_interface.hack-nic.*.id, count.index)
  ip_configuration_name   = "internal-${count.index}"
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool.id
}

resource "azurerm_network_interface_nat_rule_association" "hack-ni-natrule" {
  network_interface_id  = element(azurerm_network_interface.hack-nic.*.id, count.index)
  ip_configuration_name = "internal-${count.index}"
  nat_rule_id           = element(azurerm_lb_nat_rule.hack-natrule.*.id, count.index)
  count                 = var.count_on
}

resource "azurerm_linux_virtual_machine" "hack-vm" {
  name                  = "hack-linuxVM-${count.index}"
  resource_group_name   = var.hack-rg
  location              = var.location
  size                  = var.vm_size
  availability_set_id   = azurerm_availability_set.avset.id
  admin_username        = var.username
  admin_password        = var.password
  network_interface_ids = ["${element(azurerm_network_interface.hack-nic.*.id, count.index)}"]
  count                 = var.count_on
  admin_ssh_key {
    username   = "hackuser"
    public_key = file("id_rsa.pub")
  }
  os_disk {
    name                 = "osdisk-${count.index}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    # create_option        = "FromImage"
  }
  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }
  tags = {
    environment = "dev"
  }
}

resource "azurerm_lb" "hack-lb" {
  name                = "hack-load-balancer"
  location            = var.location
  resource_group_name = var.hack-rg
  frontend_ip_configuration {
    name                 = "LoadBalancerFrontEnd"
    public_ip_address_id = azurerm_public_ip.hack-pub-ip.id
  }
  tags = {
    environment = "dev"
  }
}

resource "azurerm_lb_probe" "lb_probe" {
  loadbalancer_id     = azurerm_lb.hack-lb.id
  name                = "tcpProbe"
  protocol            = "Tcp"
  port                = 80
  interval_in_seconds = 5
  number_of_probes    = var.count_on
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  loadbalancer_id = azurerm_lb.hack-lb.id
  name            = "BackendPool1"
}

resource "azurerm_lb_rule" "lb_rule" {
  loadbalancer_id                = azurerm_lb.hack-lb.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "LoadBalancerFrontEnd"
  enable_floating_ip             = false
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.backend_pool.id]
  idle_timeout_in_minutes        = 5
  probe_id                       = azurerm_lb_probe.lb_probe.id
  depends_on                     = [azurerm_lb_probe.lb_probe]
}

data "azurerm_public_ip" "hack-pub-ip-data" {
  name                = azurerm_public_ip.hack-pub-ip.name
  resource_group_name = var.hack-rg
}

