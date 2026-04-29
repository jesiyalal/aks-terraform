terraform {
  backend "azurerm" {
    resource_group_name  = "tf-backend-dev-rg"
    storage_account_name = "tfbackenddev123"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }
}