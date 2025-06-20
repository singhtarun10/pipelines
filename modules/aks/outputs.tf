output "aks_name" {
  value       = azurerm_kubernetes_cluster.aks.name
  description = "Name of the AKS cluster"
}

output "aks_kube_config" {
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  description = "Raw Kubeconfig"
  sensitive   = true
}

output "aks_kv_access_identity_id" {
  value       = azurerm_kubernetes_cluster.aks.kubelet_identity[0].client_id
  description = "Value needed to integrate aks kv identity with manifests"
}