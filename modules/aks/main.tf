
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = var.aks_location
  resource_group_name = var.aks_rg
  dns_prefix          = var.aks_dns_prefix

  default_node_pool {
    name       = var.aks_node_pool
    node_count = var.aks_node_count
    vm_size    = var.aks_vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  oidc_issuer_enabled = true

  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }

  tags = var.tags
}


resource "azurerm_role_assignment" "acr_pull_policy" {
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  scope                = var.acr_id
  role_definition_name = "AcrPull"

  depends_on = [azurerm_kubernetes_cluster.aks]
}


resource "azurerm_key_vault_access_policy" "access_policy1" {
  key_vault_id = var.kv_id
  tenant_id    = var.tenant_id
  object_id    = azurerm_kubernetes_cluster.aks.key_vault_secrets_provider[0].secret_identity[0].object_id

  secret_permissions = ["Get", "List"]

  depends_on = [azurerm_role_assignment.acr_pull_policy]
}


resource "azurerm_key_vault_access_policy" "access_policy2" {
  key_vault_id = var.kv_id
  tenant_id    = var.tenant_id
  object_id    = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id

  secret_permissions = ["Get", "List"]

  depends_on = [azurerm_key_vault_access_policy.access_policy1]
}