terraform {
  backend "azurerm" {
    resource_group_name  = "tarun-rg-01"
    storage_account_name = "tarunstorage011"
    container_name       = "tfstate"
    key                  = "" 
  }
}