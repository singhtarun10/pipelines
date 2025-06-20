variable "aks_name" {
  type        = string
  description = "Name of AKS Cluster"
}

variable "aks_location" {
  type        = string
  description = "Location (Region) of AKS Cluster"
}

variable "aks_rg" {
  type        = string
  description = "Resource Group of AKS Cluster"
}

variable "aks_dns_prefix" {
  type        = string
  description = "DNS Prefic for AKS Cluster"
}

variable "aks_node_pool" {
  type        = string
  description = "Name of AKS Default Node Pool"
}

variable "aks_node_count" {
  type        = number
  description = "Node Count of AKS Default Node Pool"
}

variable "aks_vm_size" {
  type        = string
  description = "VM Size of AKS Default Node Pool"
}

variable "acr_id" {
  type        = string
  description = "ACR ID to pull image from ACR"
}

variable "kv_id" {
  type        = string
  description = "KV ID for access policy"
}

variable "tenant_id" {
  type        = string
  description = "Tenant ID for access policy"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply on deployment"
}