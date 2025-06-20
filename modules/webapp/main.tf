
resource "azurerm_service_plan" "service_plan" {
  name                = var.asp_name
  resource_group_name = var.asp_rg
  location            = var.asp_location
  os_type             = "Linux"
  sku_name            = var.asp_sku
  tags                = var.tags
}


resource "azurerm_linux_web_app" "web_app" {
  name                = var.app_name
  resource_group_name = var.asp_rg
  location            = var.asp_location
  service_plan_id     = azurerm_service_plan.service_plan.id

  site_config {
    always_on = true
    application_stack {
      node_version = var.node_version
    }
  }

  app_settings = {
    "SQL_SERVER"   = format("%s.database.windows.net", var.sql_server_host)
    "SQL_USER"     = var.sql_admin_username
    "SQL_PASSWORD" = var.sql_admin_password 
    "SQL_DATABASE" = var.sql_db_name
    "SQL_ENCRYPT"  = "true"
  }

  tags = var.tags
}