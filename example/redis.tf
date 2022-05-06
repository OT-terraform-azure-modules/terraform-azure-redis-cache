provider "azurerm" {
  features {}
}

module "redis_cache" {
  source = "../"

  #Redis cache variables
  redis_name                    = "redis-example130"
  subnet_id                     = null  # if used, private endpoint cannot be configured
  public_network_access_enabled = true # if true private endpoint will not be used
  capacity                      = 1
  sku_name                      = "Premium"
  enable_non_ssl_port           = false
  minimum_tls_version           = null
  private_static_ip_address     = null
  replicas_per_master           = null
  shard_count                   = 0
  zones                         = [1, 2]

  #choose Data Persistence type any one of below
  rdb_backup_enabled = true
  aof_backup_enabled = false # Append Only File (RDB file is generated once and all the data is appended to it as it comes)

  #Redis Data Persistence variables 
  aof_storage_connection_string_0 = ""
  enable_authentication           = true # enable_authentication can only be set to false if a subnet_id is specified; and only works if there aren't existing instances within the subnet with enable_authentication set to true.
  maxmemory_reserved              = 2
  maxmemory_delta                 = 2
  maxmemory_policy                = "allkeys-lru"
  maxfragmentationmemory_reserved = 2
  notify_keyspace_events          = null
  rdb_storage_connection_string   = ""

  #Storage account variables
  storage_account_name     = "exampleakash1302"
  account_tier             = "Standard"
  account_type             = "StorageV2"
  account_replication_type = "LRS"


  tag_map = {
    name = "test"
  }



  /*----------below variables are only placeholders---------------*/
  #resource group variables
  resource_group_name     = "akash_rg"
  resource_group_location = "eastus"

  # #vnet variables
  vnet_name     = "test_vnet"

  # #subnet variables
  subnet_name       = ["subnet1"]

}