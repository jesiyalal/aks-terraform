terraform {
  backend "azurerm" {
    resource_group_name  = "tf-backend-prod-rg"
    storage_account_name = "tfbackendprod123"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}