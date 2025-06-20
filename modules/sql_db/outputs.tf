output "sql_connection_string" {
  value = format(
    "Server=tcp:%s,1433;Initial Catalog=%s;Persist Security Info=False;User ID=%s;Password=%s;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;",
    azurerm_mssql_server.sql_server.fully_qualified_domain_name,
    azurerm_mssql_database.sql_db.name,
    var.sql_admin_username,
    random_password.sql_password.result
  )
  description = "SQL Connection String to connect to Node JS WebApp"
  sensitive   = true
}

output "sql_fqdn" {
  value       = azurerm_mssql_server.sql_server.fully_qualified_domain_name
  description = "SQL Server FQDN"
}