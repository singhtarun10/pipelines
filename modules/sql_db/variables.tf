variable "sql_server_name" {
  type        = string
  description = "Name of SQL Server"
}

variable "sql_rg" {
  type        = string
  description = "Resource Group of SQL Server"
}

variable "sql_location" {
  type        = string
  description = "Location (Region) of SQL Server"
}

variable "sql_db_name" {
  type        = string
  description = "Name of SQL DB"
}

variable "sql_sku" {
  type        = string
  description = "SKU of SQL DB"
}

variable "sql_fw_rule" {
  type        = string
  description = "Firewall rule name to allow my IP Address"
}

variable "sql_start_ip" {
  type        = string
  description = "Start IP address to define range of IP Address"
}

variable "sql_end_ip" {
  type        = string
  description = "End IP address to define range of IP Address"
}

variable "sql_admin_secret_name" {
  type        = string
  description = "Secret Name of SQL Admin Username"
}

variable "sql_admin_username" {
  type        = string
  description = "Value of SQL Admin Username"
}

variable "sql_admin_secret_password" {
  type        = string
  description = "Secret Name of SQL Admin Password"
}

variable "sql_keyvault_id" {
  type        = string
  description = "Keyvault ID to store Secrets of SQL DB"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply on deployment"
}