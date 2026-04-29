module "rg" {
  source   = "../../modules/rg"
  rg_name  = var.rg_name
  location = var.location
}

module "vnet" {
  source    = "../../modules/vnet"
  vnet_name = var.vnet_name
  location  = var.location
  rg_name   = module.rg.rg_name
}

module "storage" {
  source        = "../../modules/storage"
  storage_name  = var.storage_name
  location      = var.location
  rg_name       = module.rg.rg_name
}

module "aks" {
  source       = "../../modules/aks"

  aks_name     = var.aks_name
  location     = var.location
  rg_name      = module.rg.rg_name
  dns_prefix   = "aksdns"

  subnet_id    = module.vnet.subnet_id

  node_count   = 1
  vm_size      = "Standard_B2s"

  environment  = "prod"
}
  