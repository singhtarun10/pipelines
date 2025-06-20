output "webapp_url" {
  value       = azurerm_linux_web_app.web_app.default_hostname
  description = "Default URL of the deployed Web App"
}