data "azurerm_nat_gateway" "natgw" {
  name                = "vishnu-nat-gw"
  resource_group_name = "vishnu_rg1"
}

data "azurerm_public_ip" "pip" {
  name                = "NAT-public-ip"
  resource_group_name = "vishnu_rg1"
}