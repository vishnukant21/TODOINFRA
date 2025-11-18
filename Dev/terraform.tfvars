rg_name_x = {  
  "rg2" = {
    name     = "vishnu_rg1"
    location = "Central india"

  }
 
}
stg_x = {
  "stg1" = {
    name                     = "vishnustg321"
    resource_group_name      = "vishnu_rg"
    location                 = "Central india"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
}

cnt_x = {
  "cnt2" = {
    name                  = "vishnucnt321"
    storage_account_id    = "stg1"
    container_access_type = "private"

  }
}
flexi_server_x = {
  "srv" = {
    name                   = "vishnuflexi-srver"
    resource_group_name    = "vishnu_rg1"
    location               = "Central india"
    administrator_login    = "db-login1"
    administrator_password = "admin-pass"
    sku                    = "B_Standard_B1ms"
    version                = "8.0.21"
    tags = {
      environment   = "dev"
      workload_type = "Dev/Test"

    }

  }
}
vnet_x = {
  "vnet_z" = {
    name                = "vishnuVnet"
    address_space       = ["10.16.0.0/16"]
    location            = "Central india"
    resource_group_name = "vishnu_rg1"

  }
}
sub_front_x = {
  "front_x" = {
    name                 = "frontend_vishnu"
    resource_group_name  = "vishnu_rg1"
    virtual_network_name = "vishnuVnet"
    address_prefixes     = ["10.16.0.0/24"]

  }
  "back_x" = {
    name                 = "backend_vishnu"
    resource_group_name  = "vishnu_rg1"
    virtual_network_name = "vishnuVnet"
    address_prefixes     = ["10.16.1.0/24"]

}
"bastion_x" = {
    name                 = "AzureBastionSubnet"
    resource_group_name  = "vishnu_rg1"
    virtual_network_name = "vishnuVnet"
    address_prefixes     = ["10.16.2.0/28"]

}

}

public_ip_x = {
  "pub-ip_bastion" = {
    name                = "bastion-public-ip"
    resource_group_name = "vishnu_rg1"
    location            = "Central india"
    allocation_method   = "Static"
    sku                 = "Standard"

  }
  # "pub-ip_lb" = {
  #   name                = "lb-public-ip"
  #   resource_group_name = "vishnu_rg1"
  #   location            = "Central india"
  #   allocation_method   = "Static"
  #   sku                 = "Standard"
  # }
 
  # "pub-ip_NAT" = {
  #   name                = "NAT-public-ip"
  #   resource_group_name = "vishnu_rg1"
  #   location            = "Central india"
  #   allocation_method   = "Static"
  #   sku                 = "Standard"
  # }

}

natgw_x = {
  "nat-gw" = {
    name                = "vishnu-nat-gw"
    location            = "Central india"
    resource_group_name = "vishnu_rg1"
    sku                 = "Standard"
  }
}

natgw_assoc_x = {
  "natgw_assoc" = {
    nat_gateway_name     = "vishnu-nat-gw"
    natgw_rg             = "vishnu_rg1"
    public_ip_name       = "NAT-public-ip"
    public_ip_rg         = "vishnu_rg1"
  }
}

subnet_assoc_x = {
  "subnet_assoc" = {
    subnet_name      = "frontend_vishnu"
    subnet_rg        = "vishnu_rg1"
    vnet_name        = "vishnuVnet"
    nat_gateway_name = "vishnu-nat-gw"
    nat_gateway_rg   = "vishnu_rg1"
  }
}

nic_config_x = {
  "nic_front-1" = {
    name                = "nic-frontend-vishnu-1"
    location            = "Central india"
    resource_group_name = "vishnu_rg1"
    subnet_name         = "frontend_vishnu"
    # public_ip_name      = "frontend-public-ip"
    ip_configuration = [
      {
        name                          = "ipconfig1"
        private_ip_address_allocation = "Dynamic"
      }
    ]
  }
  "nic_front-2" = {
    name                = "nic-frontend-vishnu-2"
    location            = "Central india"
    resource_group_name = "vishnu_rg1"
    subnet_name         = "frontend_vishnu"
    # public_ip_name      = "backend-public-ip"
    ip_configuration = [
      {
        name                          = "ipconfig2"
        private_ip_address_allocation = "Dynamic"
      }
    ]
  }
   "nic_back-1" = {
    name                = "nic-backend-vishnu-1"
    location            = "Central india"
    resource_group_name = "vishnu_rg1"
    subnet_name         = "backend_vishnu"
    # public_ip_name      = "backend-public-ip"
    ip_configuration = [
      {
        name                          = "ipconfig3"
        private_ip_address_allocation = "Dynamic"
      }
    ]
  }
}
frontend_vm_x = {
  "frontend_vm_1" = {
    name                            = "vishnu-frontend-vm-1"
    location                        = "Central india"
    resource_group_name             = "vishnu_rg1"
    network_interface_name          = "nic-frontend-vishnu-1"
    size                            = "Standard_B1s"
    admin_username                  = "admin-login"
    admin_password                  = "vm-password"
    disable_password_authentication = false
    os_disk = {
      "osdisk-vishnu-1" = {
        name                 = "osdisk-vishnu-1"
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
        disk_size_gb         = 30
      }
    }
    source_image_reference = {
      "Canonnical" = {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-LTS"
        version   = "latest"
      }

    }
    tags = {
      role = "frontend"
    }
  }
  "frontend_vm_2" = {
    name                            = "vishnu-frontend-vm-2"
    location                        = "Central india"
    resource_group_name             = "vishnu_rg1"
    network_interface_name          = "nic-frontend-vishnu-2"
    size                            = "Standard_B1s"
    admin_username                  = "admin-login"
    admin_password                  = "vm-password"
    disable_password_authentication = false
    
    os_disk = {
      "osdisk-vishnu-2" = {
        name                 = "osdisk-vishnu-2"
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
        disk_size_gb         = 30
      }
    }

    source_image_reference = {
      "Canonnical" = {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-LTS"
        version   = "latest"
      }

    }
    tags = {
      role = "frontend"
    }
  }
  
}


backend_vm_x = {
  "backend_vm_1" = {
    name                            = "vishnu-backend-vm-1"
    location                        = "Central india"
    resource_group_name             = "vishnu_rg1"
    size                            = "Standard_B1s"
    network_interface_name          = "nic-backend-vishnu-1"
    admin_username                  = "admin-login"
    admin_password                  = "vm-password"
    disable_password_authentication = false
    os_disk = {
      "osdisk-backend-vishnu-1" = {
        name                 = "osdisk-vishnu-3"
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
        disk_size_gb         = 30
      }
    }
    source_image_reference = {
      "Canonnical" = {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-LTS"
        version   = "latest"
      }

    }
    tags = {
      role = "backend"
    }
  }
}

frontend_lb_x = {
  "frontend_lb_1" = {
    name                = "vishnu-frontend-lb-1"
    location            = "Central india"
    resource_group_name = "vishnu_rg1"
    sku                 = "Standard"
    frontend_ip_configuration = {
      "frontend_ip_1" = {
        name                 = "frontend-ip-1"
        public_ip_address_id = ["lb-public-ip"]
      }
    }
  }
}

backend_pool_x = {
  "pool1" = {
    name            = "frontend-backend-pool"
    loadbalancer_id = "vishnu-frontend-lb-1"
  }
}

pool_assoc_x = {
  "pool_assoc_1" = {
    network_interface_name  = "nic-frontend-vishnu-1"
    ip_configuration_name   = "ipconfig1"
    resource_group_name     = "vishnu_rg1"
  }
  "pool_assoc_2" = {
    network_interface_name  = "nic-frontend-vishnu-2"
    ip_configuration_name   = "ipconfig2"
    resource_group_name     = "vishnu_rg1"
  }
}

probes_x = {
  "frontend_probe" = {
    name     = "frontend-probe"
    port     = 80
    protocol = "Tcp"
  }
}

lb_rules_x = {
  "lb_rules_1" = {
    name                           = "http-rule"
    protocol                       = "Tcp"
    frontend_port                  = 80
    backend_port                   = 80
    frontend_ip_configuration_name = "frontend_ip_1"
    backend_pool_key               = "pool1"        # pool assoc ke liye key
    probe_key                      = "frontend_probe"
  }
}

NSG_x = {
  "NSG_front" = {
    name                = "vishnu-nsg-front"
    location            = "Central India"
    resource_group_name = "vishnu_rg1"
    security_rule = {
      "rule1" = {
        name                       = "Allow-HTTP"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
      "rule2" = {
        name                       = "Allow-SSH"
        priority                   = 200
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    }
    tags = {
      environment = "dev"
    }
  }
  "NSG_back" = {
    name                = "vishnu-nsg-back"
    location            = "Central India"
    resource_group_name = "vishnu_rg1"
    security_rule = {
      "rule1" = {
        name                       = "Allow-SSH"
        priority                   = 201
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
      "rule2" = {
        name                       = "Allow-HTTP"
        priority                   = 210
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "5000"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    }
    tags = {
      environment = "Dev"
    }
  }
}
sql-server_x = {
  "sql-server" = {
    name                         = "vishnu-sql-server"
    resource_group_name          = "vishnu_rg1"
    location                     = "Central india"
    version                      = "12.0"
    administrator_login          = "vishnuc1985"
    administrator_login_password = "Oneday@123"
    minimum_tls_version          = "1.2"
    tags = {
      environment = "dev"
      project     = "SQLProject"
    }
  }
}

nsg_assoc_x = {
  "nsg_assoc_1" = {
    subnet_name         = "frontend_vishnu"
    nsg_name            = "vishnu-nsg-front"
    resource_group_name = "vishnu_rg1"
    vnet_name           = "vishnuVnet"
  }
  "nsg_assoc_2" = {
    subnet_name         = "backend_vishnu"
    nsg_name            = "vishnu-nsg-back"
    resource_group_name = "vishnu_rg1"
    vnet_name           = "vishnuVnet"
  }
}


sql-database_x = {
  "sql-database" = {
    name         = "vishnu-sql-database"
    server_id    = "sql"
    max_size_gb  = 2
    sku_name     = "S0"
    enclave_type = "VBS"
    tags = {
      environment = "dev"
      project     = "SQLProject"
    }
  }
}
key_vaults_x = {
  "key-vault" = {
    name                = "vishnu-key-vault"
    resource_group_name = "vishnu_rg"
    location            = "Central india"
    sku_name            = "standard"
    tenant_id           = "a65d0b0e-fc3d-4f7c-81d7-18125e465472"  # Replace with your actual tenant ID
    tags = {
      environment = "dev"
      project     = "KeyVaultProject"
    }
  }
}
kv_admin_roles_x = {
  "kv_admin" = {
    principal_id         = "6cb8ab23-ea43-433e-a619-6277ca11630a"  # Replace with your actual principal ID
    role_definition_name = "Key Vault Administrator"
  }
}
dnszone_x = {
  "DNSzone1" = {
    name                = "privatelink.vaultcore.azure.net"
    resource_group_name = "vishnu_rg1"
  }
}
dnslink_x = {
  "dnslink1" = {
    name                  = "kv-dns-link"
    resource_group_name   = "vishnu_rg1"
    private_dns_zone_name = "privatelink.vaultcore.azure.net"
    virtual_network_id    = "vnetd"  # Replace with actual virtual network ID
  }
}

kv_pe_x = {
  "kv_pe1" = {
    name                = "kv-pe-backend"
    location            = "Central india"
    resource_group_name = "vishnu_rg1"
    subnet_name         = "backend_vishnu"
    key_vault_name      = "vishnu-key-vault"

    private_service_connection = {
      "psc1" = {
        name                           = "psc-kv1"
        private_connection_resource_id = "kvi"  # Replace with actual resource ID
        subresource_names              = ["vault"]
        is_manual_connection           = false
      }
    }

    private_dns_zone_group = {
      "pdzg1" = {
        name                 = "pdzg-kv1"
        private_dns_zone_ids = ["kv"]  # Replace with actual DNS zone IDs
      }
    }
  }
  "kv_pe2" = {
    name                = "kv-pe-frontend"
    location            = "Central india"
    resource_group_name = "vishnu_rg1"
    subnet_name         = "frontend_vishnu" 
    key_vault_name      = "vishnu-key-vault" 

    private_service_connection = {
      "psc1" = {
        name                           = "psc-kv2"
        private_connection_resource_id = "kvi"  # Replace with actual resource ID
        subresource_names              = ["vault"]
        is_manual_connection           = false
      }
    }

    private_dns_zone_group = {
      "pdzg1" = {
        name                 = "pdzg-2"
        private_dns_zone_ids = ["kv"]  # Replace with actual DNS zone IDs
      }
    }
  }
}

bastion-host_x = {
  "bastion-host" = {
    name                 = "bastion-host-vishnu"
    location             = "Central india"
    resource_group_name  = "vishnu_rg1"
    virtual_network_name = "vishnuVnet"
    ip_configuration = {
      "ipconfig1" = {
        name = "bastion-ipconfig"
      }
    }
  }
}