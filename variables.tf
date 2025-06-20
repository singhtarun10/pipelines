variable "stage_prefix" {
  type        = string
  description = "Prefix of the Stage"
}

variable "location" {
  type        = string
  description = "Location or Region to be set"
}

variable "kv_sku" {
  type        = string
  description = "SKU for KeyVault"
}

variable "sql_sku" {
  type        = string
  description = "SKU for SQL DB"
}

variable "sql_fw_rule" {
  type        = string
  description = "Firewall Rule Name for SQL"
}

variable "sql_start_ip" {
  type        = string
  description = "Start IP address to define range of IP Address"
}

variable "sql_end_ip" {
  type        = string
  description = "End IP address to define range of IP Address"
}

variable "sql_admin_username" {
  type        = string
  description = "Value SQL Admin Username"
}

variable "sql_admin_secretname" {
  type        = string
  description = "Variable to store Admin name as Secret"
}

variable "sql_admin_secretpassword" {
  type        = string
  description = "Variable to store Admin Password as Secret"
}

variable "asp_sku" {
  type        = string
  description = "SKU for App Service Plan"
}

variable "app_node_version" {
  type        = string
  description = "Node Version for the Web App"
}

variable "acr_sku" {
  type        = string
  description = "SKU for ACR"
}

variable "aks_node_pool" {
  type        = string
  description = "Name of Node Pool for AKS"
}

variable "aks_node_count" {
  type        = number
  description = "Count of Node Pool for AKS"
}

variable "aks_vm_size" {
  type        = string
  description = "VM Size of Node Pool for AKS"
}