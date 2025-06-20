data "azurerm_client_config" "client_config" {

}

resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.location

  tags = local.tags
}

module "keyvault" {
  source       = "./modules/keyvault"
  kv_name      = local.kv_name
  kv_location  = var.location
  kv_rg        = local.rg_name
  kv_sku       = var.kv_sku
  kv_object_id = data.azurerm_client_config.client_config.object_id
  kv_tenant_id = data.azurerm_client_config.client_config.tenant_id
  tags         = local.tags

  depends_on = [azurerm_resource_group.rg]
}


module "sql_db" {
  source                    = "./modules/sql_db"
  sql_server_name           = local.sql_server_name
  sql_rg                    = local.rg_name
  sql_location              = var.location
  sql_db_name               = local.sql_db_name
  sql_sku                   = var.sql_sku
  sql_fw_rule               = var.sql_fw_rule
  sql_start_ip              = var.sql_start_ip
  sql_end_ip                = var.sql_end_ip
  sql_admin_secret_name     = var.sql_admin_secretname
  sql_admin_secret_password = var.sql_admin_secretpassword
  sql_admin_username        = var.sql_admin_username
  sql_keyvault_id           = module.keyvault.keyvault_id
  tags                      = local.tags

  depends_on = [module.keyvault]
}

data "azurerm_key_vault_secret" "sql_admin_password" {
  name         = var.sql_admin_secretpassword
  key_vault_id = module.keyvault.keyvault_id

  depends_on = [module.keyvault, module.sql_db]
}

module "webapp" {
  source             = "./modules/webapp"
  asp_name           = local.asp_name
  asp_rg             = local.rg_name
  asp_location       = var.location
  asp_sku            = var.asp_sku
  app_name           = local.app_name
  node_version       = var.app_node_version
  sql_admin_username = var.sql_admin_username
  sql_db_name        = local.sql_db_name
  sql_server_host    = local.sql_server_name
  sql_admin_password = data.azurerm_key_vault_secret.sql_admin_password.value
  tags               = local.tags

  depends_on = [module.sql_db, data.azurerm_key_vault_secret.sql_admin_password]
}

module "acr" {
  source       = "./modules/acr"
  acr_name     = local.acr_name
  acr_location = var.location
  acr_rg       = local.rg_name
  acr_sku      = var.acr_sku
  tags         = local.tags

  depends_on = [module.webapp]
}


module "aks" {
  source         = "./modules/aks"
  aks_name       = local.aks_name
  aks_location   = var.location
  aks_rg         = local.rg_name
  aks_dns_prefix = local.aks_dns_prefix
  aks_node_pool  = var.aks_node_pool
  aks_node_count = var.aks_node_count
  aks_vm_size    = var.aks_vm_size
  acr_id         = module.acr.acr_id
  kv_id          = module.keyvault.keyvault_id
  tenant_id      = data.azurerm_client_config.client_config.tenant_id
  tags           = local.tags

  depends_on = [module.acr]
}

provider "kubectl" {
  host                   = yamldecode(module.aks.aks_kube_config).clusters[0].cluster.server
  client_certificate     = base64decode(yamldecode(module.aks.aks_kube_config).users[0].user.client-certificate-data)
  client_key             = base64decode(yamldecode(module.aks.aks_kube_config).users[0].user.client-key-data)
  cluster_ca_certificate = base64decode(yamldecode(module.aks.aks_kube_config).clusters[0].cluster.certificate-authority-data)
  load_config_file       = false
}

provider "kubernetes" {
  host                   = yamldecode(module.aks.aks_kube_config).clusters[0].cluster.server
  client_certificate     = base64decode(yamldecode(module.aks.aks_kube_config).users[0].user.client-certificate-data)
  client_key             = base64decode(yamldecode(module.aks.aks_kube_config).users[0].user.client-key-data)
  cluster_ca_certificate = base64decode(yamldecode(module.aks.aks_kube_config).clusters[0].cluster.certificate-authority-data)
}


resource "kubectl_manifest" "secret_provider" {
  yaml_body = templatefile("${path.module}/k8s-manifests/secret-provider.yaml.tftpl", {
    aks_kv_access_identity_id = module.aks.aks_kv_access_identity_id
    kv_name                   = local.kv_name
    sql_admin_secret_name     = var.sql_admin_secretname
    sql_password_secret_name  = var.sql_admin_secretpassword
    tenant_id                 = data.azurerm_client_config.client_config.tenant_id
  })

  depends_on = [module.aks, module.keyvault, module.sql_db]
}

resource "kubernetes_secret" "sql_config" {
  metadata {
    name      = "sql-config-secrets"
    namespace = "default" 
  }

  data = {
    sqlserver   = module.sql_db.sql_fqdn
    sqldatabase = local.sql_db_name
  }

  type = "Opaque"

  depends_on = [module.sql_db]
}
