output "acr_login_server" {
  value       = azurerm_container_registry.acr.login_server
  description = "ACR login server (e.g., epamacr.azurecr.io)"
}

output "acr_id" {
  value       = azurerm_container_registry.acr.id
  description = "ACR resource ID"
}
