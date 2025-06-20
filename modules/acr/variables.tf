variable "acr_name" {
  type        = string
  description = "Name of Azure Container Registry"
}

variable "acr_rg" {
  type        = string
  description = "Name of Resource Group of Azure Container Registry"
}

variable "acr_location" {
  type        = string
  description = "Location (Region) of Azure Container Registry"
}

variable "acr_sku" {
  type        = string
  description = "SKU of Azure Container Registry"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply on deployment"
}