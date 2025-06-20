
resource "random_password" "sql_password" {
  length  = 16
  special = true
}


resource "azurerm_mssql_server" "sql_server" {
  name                         = var.sql_server_name
  resource_group_name          = var.sql_rg
  location                     = var.sql_location
  version                      = "12.0"
  administrator_login          = var.sql_admin_username
  administrator_login_password = random_password.sql_password.result

  tags = var.tags
}


resource "azurerm_mssql_database" "sql_db" {
  name      = var.sql_db_name
  server_id = azurerm_mssql_server.sql_server.id
  sku_name  = var.sql_sku
  tags      = var.tags

  depends_on = [azurerm_mssql_server.sql_server]
}


resource "azurerm_mssql_firewall_rule" "azure_services" {
  name             = "AllowAzureServices"
  server_id        = azurerm_mssql_server.sql_server.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"

  depends_on = [azurerm_mssql_server.sql_server]
}


resource "azurerm_mssql_firewall_rule" "allow_my_ip" {
  name             = var.sql_fw_rule
  server_id        = azurerm_mssql_server.sql_server.id
  start_ip_address = var.sql_start_ip
  end_ip_address   = var.sql_end_ip

  depends_on = [azurerm_mssql_server.sql_server]
}


resource "azurerm_key_vault_secret" "sql_admin_username" {
  name         = var.sql_admin_secret_name
  value        = var.sql_admin_username
  key_vault_id = var.sql_keyvault_id
  tags         = var.tags

  depends_on = [azurerm_mssql_database.sql_db]
}


resource "azurerm_key_vault_secret" "sql_admin_password" {
  name         = var.sql_admin_secret_password
  value        = random_password.sql_password.result
  key_vault_id = var.sql_keyvault_id
  tags         = var.tags

  depends_on = [random_password.sql_password, azurerm_mssql_database.sql_db]
}