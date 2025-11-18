data "azurerm_key_vault_secret" "db-login" {
  name                = "db-login1"
  key_vault_id        = data.azurerm_key_vault.kvi.id
}
data "azurerm_key_vault_secret" "db-pass" {
  name                = "admin-pass"
  key_vault_id        = data.azurerm_key_vault.kvi.id
}
data "azurerm_key_vault" "kvi" {
  name                = "vishnu-key-vault"
  resource_group_name = "vishnu_rg"
}