variable "asp_name" {
  type        = string
  description = "Name for the App Service Plan"
}

variable "asp_rg" {
  type        = string
  description = "Name for the Resource Group of App Service Plan"
}

variable "asp_location" {
  type        = string
  description = "Location (Region) for the App Service Plan"
}

variable "asp_sku" {
  type        = string
  description = "SKU for the App Service Plan"
}

variable "app_name" {
  type        = string
  description = "Name for the App Service"
}

variable "node_version" {
  type        = string
  description = "Node Version for the Web App"
}

variable "sql_server_host" {
  type        = string
  description = "SQL Server Host"
}

variable "sql_admin_username" {
  type        = string
  description = "SQL Admin Username"
}

variable "sql_admin_password" {
  type        = string
  description = "SQL Admin Password"
}

variable "sql_db_name" {
  type        = string
  description = "SQL DB Name"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply on deployment"
}