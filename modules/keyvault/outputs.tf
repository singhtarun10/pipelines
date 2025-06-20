output "keyvault_id" {
  value       = azurerm_key_vault.kv.id
  description = "Keyvault ID"
}

output "keyvault_name" {
  value       = azurerm_key_vault.kv.name
  description = "Name of the Keyvault"
}