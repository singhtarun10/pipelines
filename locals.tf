locals {
  kv_name = format("%s-kv", var.stage_prefix)

  rg_name = format("%s-rg", var.stage_prefix)

  sql_server_name = format("%s-sql-server", var.stage_prefix)
  sql_db_name     = format("%s-sql-db", var.stage_prefix)

  asp_name = format("%s-asp", var.stage_prefix)
  app_name = format("%s-app", var.stage_prefix)

  acr_name = lower(replace(format("%sacr", var.stage_prefix), "-", ""))

  aks_name       = format("%s-aks", var.stage_prefix)
  aks_dns_prefix = format("%s-dns", var.stage_prefix)

  docker_image_name = format("%s-image", var.stage_prefix)

  tags = {
    Creator = "tarunkumar_singh@epam.com"
  }
}