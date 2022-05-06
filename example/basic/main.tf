# This creates a Azure cache for redis in Basic sku with public access enabled and Data Persistence disabled

provider "azurerm" {
  features {}
}

module "redis_cache" {
  source = "../../"

  #resource group variables
  resource_group_name     = "akash_rg"
  resource_group_location = "eastus"

  #Redis cache variables
  redis_name                    = "redis-example130"
  subnet_id                     = null # if used, private endpoint cannot be configured
  public_network_access_enabled = true # if true private endpoint will not be used
  capacity                      = 0
  sku_name                      = "Basic"
  enable_non_ssl_port           = false
  minimum_tls_version           = null
  private_static_ip_address     = null
  replicas_per_master           = null
  shard_count                   = 0
  zones                         = []

  #choose Data Persistence type any one of below
  rdb_backup_enabled = false
  aof_backup_enabled = false

  tag_maps = {
    name = "test"
  }
}