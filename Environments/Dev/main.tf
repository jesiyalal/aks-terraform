module "rg" {
  source   = "../../modules/rg"
  rg_name  = var.rg_name
  location = var.location
}

module "vnet" {
  source   = "../../modules/vnet"
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

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = var.location
  resource_group_name = module.rg.rg_name
  dns_prefix          = "aksdns"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size = "Standard_B2s"
    vnet_subnet_id = module.vnet.subnet_id
  }

  identity {
    type = "SystemAssigned"
  }
  network_profile {
    network_plugin     = "azure"
    service_cidr       = "10.2.0.0/16"
    dns_service_ip     = "10.2.0.10"
    
  }
}