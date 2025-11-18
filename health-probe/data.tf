data "azurerm_lb" "lb" {
    name                = "vishnu-frontend-lb-1"
    resource_group_name = "vishnu_rg1"
}