stage_prefix = "qa-tarun"

location = "Central US"


kv_sku = "standard"


sql_sku                  = "S2"
sql_admin_username       = "tarun"
sql_fw_rule              = "Allow-my-IP"
sql_start_ip             = "203.170.48.2"
sql_end_ip               = "203.170.48.2"
sql_admin_secretname     = "SQL-USER"
sql_admin_secretpassword = "SQL-PASSWORD"


asp_sku          = "P0v3"
app_node_version = "20-lts"


acr_sku = "Basic"


aks_node_pool  = "tarun"
aks_node_count = 1
aks_vm_size    = "Standard_D2ads_v5"