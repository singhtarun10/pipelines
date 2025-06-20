
resource "azurerm_key_vault" "kv" {
  name                = var.kv_name
  location            = var.kv_location
  resource_group_name = var.kv_rg
  sku_name            = var.kv_sku
  tenant_id           = var.kv_tenant_id

  purge_protection_enabled   = false
  soft_delete_retention_days = 7

  tags = var.tags
}


resource "azurerm_key_vault_access_policy" "access_policies" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = var.kv_tenant_id
  object_id    = var.kv_object_id

  secret_permissions = [
    "Get",
    "Set",
    "List",
    "Delete",
    "Purge",
    "Recover",
    "Backup",
    "Restore"
  ]
}