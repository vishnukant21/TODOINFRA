data "azurerm_subnet" "subnet" {
  name                 = "frontend_jay"
  virtual_network_name = "vishnuVnet"
  resource_group_name  = "vishnu_rg1"
}
data "azurerm_nat_gateway" "natgw" {
  name                = "vishnu-nat-gw"
  resource_group_name = "vishnu_rg1"
}