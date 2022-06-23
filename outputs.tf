output "redis_id" {
  description = "The Route ID."
  value       = azurerm_redis_cache.redis_cache.id
}
output "hostname" {
  description = "The Hostname of the Redis Instance"
  value       = azurerm_redis_cache.redis_cache.hostname
}
output "ssl_port" {
  description = "The SSL Port of the Redis Instance"
  value       = azurerm_redis_cache.redis_cache.ssl_port
}
output "port" {
  description = "The non-SSL Port of the Redis Instance"
  value       = azurerm_redis_cache.redis_cache.port
  sensitive   = true
}
output "primary_access_key" {
  description = "The Primary Access Key for the Redis Instance"
  value       = azurerm_redis_cache.redis_cache.primary_access_key
  sensitive   = true
}
output "secondary_access_key" {
  description = "The Secondary Access Key for the Redis Instance"
  value       = azurerm_redis_cache.redis_cache.secondary_access_key
  sensitive   = true
}
output "primary_connection_string" {
  description = "The primary connection string of the Redis Instance."
  value       = azurerm_redis_cache.redis_cache.primary_connection_string
  sensitive   = true
}
output "secondary_connection_string" {
  description = "The secondary connection string of the Redis Instance."
  value       = azurerm_redis_cache.redis_cache.secondary_connection_string
  sensitive   = true
}


# /*----------storage account------------- */
output "storage_account_name" {
  description = "The name of storage account"
  value       = var.aof_backup_enabled == true || var.rdb_backup_enabled == true ? module.storage_account.0.storage_account_name : null
}
output "storage_account_primary_blob_endpoint" {
  description = "The endpoint URL for Blob container "
  value       = var.aof_backup_enabled == true || var.rdb_backup_enabled == true ? module.storage_account.0.primary_blob_endpoint : null
}
output "storage_account_secondary_blob_endpoint" {
  description = "The endpoint URL for Blob container"
  value       = var.aof_backup_enabled == true || var.rdb_backup_enabled == true ? module.storage_account.0.secondary_blob_endpoint : null
}
output "storage_account_primary_access_key" {
  description = "The primary access key for the storage account"
  value       = var.aof_backup_enabled == true || var.rdb_backup_enabled == true ? module.storage_account.0.primary_access_key : null
  sensitive   = true
}
output "storage_account_secondary_access_key" {
  description = "The primary access key for the storage account"
  value       = var.aof_backup_enabled == true || var.rdb_backup_enabled == true ? module.storage_account.0.secondary_access_key : null
  sensitive   = true
}
