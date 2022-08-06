locals { 
nsgrules = {
  
    rdp = {
      name                        = "DenyVNetInboundFromInternet"
      priority                    = 101
      direction                   = "Inbound"
      access                      = "Deny"
      protocol                    = "*"
      source_port_range           = "*"
      destination_port_range      = "*"
      source_address_prefix       = "Internet"
      destination_address_prefix  = "VirtualNetwork"
    }

    sql = {
      name                       = "sql"
      priority                   = 102
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "1433"
      source_address_prefix      = "SqlManagement"
      destination_address_prefix = "*"
    }

    http = {
      name                       = "http"
      priority                   = 201
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}
