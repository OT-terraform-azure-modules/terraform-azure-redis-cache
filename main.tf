resource "azurerm_redis_cache" "redis_cache" {
  name                          = var.redis_name
  resource_group_name           = var.resource_group_name
  location                      = var.resource_group_location
  capacity                      = var.capacity
  family                        = lookup(var.redis_family, var.sku_name)
  sku_name                      = var.sku_name
  enable_non_ssl_port           = var.enable_non_ssl_port
  minimum_tls_version           = var.minimum_tls_version
  private_static_ip_address     = var.private_static_ip_address
  public_network_access_enabled = var.sku_name == "Premium" ? var.public_network_access_enabled : false
  shard_count                   = var.sku_name == "Premium" ? var.shard_count : 0
  subnet_id                     = var.subnet_id
  zones                         = var.zones
  replicas_per_primary          = var.replicas_per_primary
  redis_version                 = var.redis_version
  tags                          = var.tag_map

  dynamic "redis_configuration" {
    for_each = var.patch_schedule != null ? [var.patch_schedule] : []
    content {
      aof_backup_enabled              = var.aof_backup_enabled
      aof_storage_connection_string_0 = var.aof_backup_enabled == true ? var.aof_storage_connection_string_0 : null
      enable_authentication           = var.enable_authentication
      maxfragmentationmemory_reserved = var.sku_name == "Premium" || var.sku_name == "Standard" ? var.maxfragmentationmemory_reserved : null
      maxmemory_delta                 = var.sku_name == "Premium" || var.sku_name == "Standard" ? var.maxmemory_delta : null
      maxmemory_policy                = var.maxmemory_policy
      maxmemory_reserved              = var.sku_name == "Premium" || var.sku_name == "Standard" ? var.maxmemory_reserved : null
      notify_keyspace_events          = var.notify_keyspace_events
      rdb_backup_enabled              = var.sku_name == "Premium" && var.rdb_backup_enabled == true ? true : false
      rdb_backup_frequency            = var.sku_name == "Premium" && var.rdb_backup_enabled == true ? var.rdb_backup_frequency : null
      rdb_backup_max_snapshot_count   = var.sku_name == "Premium" && var.rdb_backup_enabled == true ? var.rdb_backup_max_snapshot_count : null
      rdb_storage_connection_string   = var.sku_name == "Premium" && var.rdb_backup_enabled == true ? var.rdb_storage_connection_string : null
    }
  }
  dynamic "patch_schedule" {
    for_each = var.patch_schedule != null ? [var.patch_schedule] : []
    content {
      day_of_week    = var.patch_schedule.day_of_week
      start_hour_utc = var.patch_schedule.start_hour_utc
    }
  }
}


data "azurerm_resource_group" "existing-resource-group" {
  count               = var.public_network_access_enabled == false ? 1 : 0
  name = var.resource_group_name
}

data "azurerm_virtual_network" "existing-virtual-network" {
  count               = var.public_network_access_enabled == false ? 1 : 0
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
}

data "azurerm_subnet" "existing-subnet" {
  count               = var.public_network_access_enabled == false ? 1 : 0
  name                 = var.subnet_name[0]
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
}

resource "azurerm_private_endpoint" "private_endpoint" {
  count               = var.public_network_access_enabled == false ? 1 : 0
  name                = format("%s-private-endpoint", azurerm_redis_cache.redis_cache.name)
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  subnet_id           = data.azurerm_subnet.existing-subnet[0].id

  private_service_connection {
    name                           = var.private_service_connection_name
    private_connection_resource_id = azurerm_redis_cache.redis_cache.id
    is_manual_connection           = false
    subresource_names              = ["redisCache"]
  }
}

data "azurerm_private_endpoint_connection" "private_endpoint_connection" {
  count               = var.public_network_access_enabled == false ? 1 : 0
  name                = azurerm_private_endpoint.private_endpoint.0.name
  resource_group_name = var.resource_group_name
  depends_on          = [azurerm_redis_cache.redis_cache]
}

resource "azurerm_private_dns_zone" "private_dns_zone" {
  count               = var.public_network_access_enabled == false ? 1 : 0
  name                = var.private_dns_zone_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_zone_virtual_network_link" {
  count                 = var.public_network_access_enabled == false ? 1 : 0
  name                  = var.private_dns_zone_virtual_network_link_name
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone.0.name
  virtual_network_id    = data.azurerm_virtual_network.existing-virtual-network[0].id
}

resource "azurerm_private_dns_a_record" "arecord1" {
  count               = var.public_network_access_enabled == false ? 1 : 0
  name                = azurerm_redis_cache.redis_cache.name
  zone_name           = azurerm_private_dns_zone.private_dns_zone.0.name
  resource_group_name = var.resource_group_name
  ttl                 = 300
  records             = [data.azurerm_private_endpoint_connection.private_endpoint_connection.0.private_service_connection.0.private_ip_address]
}

module "storage_account" {
  count                    = var.aof_backup_enabled == true || var.rdb_backup_enabled == true ? 1 : 0
  source                   = "./modules/storage-account/"
  storage_account_name     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.resource_group_location
  account_tier             = var.account_tier
  account_type             = var.account_type
  account_replication_type = var.account_replication_type
  tag_map                  = var.tag_map
}
