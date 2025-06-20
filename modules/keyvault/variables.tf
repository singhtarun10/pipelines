variable "kv_name" {
  type        = string
  description = "Name of the Keyvault"
}

variable "kv_location" {
  type        = string
  description = "Location (Region) of the Keyvault"
}

variable "kv_rg" {
  type        = string
  description = "Resource Group the Keyvault belongs to"
}

variable "kv_sku" {
  type        = string
  description = "SKU of the Keyvault"
}

variable "kv_tenant_id" {
  type        = string
  description = "Tenant ID of the organization"
}

variable "kv_object_id" {
  type        = string
  description = "Object ID of Service Principle"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply on deployment"
}