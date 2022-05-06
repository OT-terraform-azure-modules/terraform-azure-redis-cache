variable "resource_group_name" {
  description = "(Required) The name of the resource group in which to create the Redis instance."
  type        = string
}

variable "redis_name" {
  description = "(Required) The name of the Redis instance. Changing this forces a new resource to be created."
  type        = string
}
variable "resource_group_location" {
  description = "(Required) The location of the resource group."
  type        = string
}


variable "capacity" {
  description = "(Required) The size of the Redis cache to deploy. Valid values for a SKU family of C (Basic/Standard) are 0, 1, 2, 3, 4, 5, 6, and for P (Premium) family are 1, 2, 3, 4."
  type        = number
}
variable "sku_name" {
  type        = string
  description = "(Required) The SKU of Redis to use. Possible values are Basic, Standard and Premium."
}
variable "enable_non_ssl_port" {
  type        = bool
  default     = false
  description = "(Optional) Enable the non-SSL port (6379) - disabled by default."
}
variable "minimum_tls_version" {
  type        = string
  default     = null
  description = "(Optional) The minimum TLS version. Defaults to 1.0."
}
variable "private_static_ip_address" {
  type        = string
  default     = null
  description = "(Optional) The Static IP Address to assign to the Redis Cache when hosted inside the Virtual Network. Changing this forces a new resource to be created."
}
variable "replicas_per_master" {
  type        = number
  default     = 0
  description = "(Optional) Amount of replicas to create per master for this Redis Cache."
}
variable "shard_count" {
  type        = number
  default     = 0
  description = "(Optional) Only available when using the Premium SKU The number of Shards to create on the Redis Cluster."
}
variable "zones" {
  type        = list(number)
  default     = null
  description = "(Optional) A list of a one or more Availability Zones, where the Redis Cache should be allocated."
}



variable "redis_family" {
  description = "(Required) The SKU family/pricing group to use. Valid values are `C` (for `Basic/Standard` SKU family) and `P` (for `Premium`)"
  type        = map(any)
  default = {
    Basic    = "C"
    Standard = "C"
    Premium  = "P"
  }
}
variable "patch_schedule" {
  description = "(Optional) The window for redis maintenance. The Patch Window lasts for 5 hours from the `start_hour_utc` "
  type = object({
    day_of_week        = string # (Required) the Weekday name - possible values include Monday, Tuesday, Wednesday etc.
    start_hour_utc     = number # (Optional) the Start Hour for maintenance in UTC - possible values range from 0 - 23.
    maintenance_window = string # (Optional) The ISO 8601 timespan which specifies the amount of time the Redis Cache can be updated. Defaults to PT5H.
  })
  default = null
}
variable "aof_storage_connection_string_0" {
  description = "(Optional) First Storage Account connection string for AOF persistence."
  type        = string
  default     = null
}
variable "aof_storage_connection_string_1" {
  description = "(Optional) Second Storage Account connection string for AOF persistence."
  type        = string
  default     = null
}
variable "enable_authentication" {
  description = "(Optional) If set to false, the Redis instance will be accessible without authentication. Defaults to true."
  type        = bool
  default     = false
}
variable "maxmemory_reserved" {
  description = "(Optional) Second Storage Account connection string for AOF persistence."
  type        = number
  default     = 0
}
variable "maxmemory_delta" {
  description = "(Optional) Second Storage Account connection string for AOF persistence."
  type        = number
  default     = 0
}
variable "maxmemory_policy" {
  description = "(Optional) Second Storage Account connection string for AOF persistence."
  type        = string
  default     = null
}
variable "maxfragmentationmemory_reserved" {
  description = "(Optional) Second Storage Account connection string for AOF persistence."
  type        = number
  default     = 0
}
variable "notify_keyspace_events" {
  description = "(Optional) Second Storage Account connection string for AOF persistence."
  type        = string
  default     = null
}




variable "replicas_per_primary" {
  description = "(Optional) Amount of replicas to create per primary for this Redis Cache. If both replicas_per_primary and replicas_per_master are set, they need to be equal."
  type        = number
  default     = null
}
variable "redis_version" {
  description = "(Optional) Redis version. Only major version needed. Valid values: 4, 6."
  type        = number
  default     = null
}

variable "subnet_id" {
  description = "(Optional) Only available when using the Premium SKU The ID of the Subnet within which the Redis Cache should be deployed. This Subnet must only contain Azure Cache for Redis instances without any other type of resources. Changing this forces a new resource to be created."
  type        = any
}

variable "public_network_access_enabled" {
  description = "(Optional) Whether or not public network access is allowed for this Redis Cache. true means this resource could be accessed by both public and private endpoint. false means only private endpoint access is allowed. Defaults to true."
  type        = bool
  default     = true
}

variable "rdb_backup_enabled" {
  description = "(Optional)Enable or disbale Redis Database Backup. Only supported on Premium SKU's"
  type        = bool
  default     = false
}

variable "aof_backup_enabled" {
  description = "(Optional) Enable or disable AOF persistence for this Redis Cache."
  type        = bool
  default     = false
}

variable "rdb_backup_frequency" {
  description = "(Optional) The Backup Frequency in Minutes. Only supported on Premium SKU's. Possible values are: `15`, `30`, `60`, `360`, `720` and `1440`"
  type        = number
  default     = 60
}

variable "rdb_backup_max_snapshot_count" {
  description = "(Optional) The maximum number of snapshots to create as a backup. Only supported for Premium SKU's"
  type        = number
  default     = 1
}
variable "rdb_storage_connection_string" {
  description = "(Optional) The Connection String to the Storage Account. Only supported for Premium SKU's"
  type        = string
  default     = null
}

variable "tag_map" {
  description = "(Optional) Tags for Resource Group"
  type        = map(string)
}


/*--------------Vnet Variable ---------------*/
variable "vnet_name" {
  description = "(Required) The name of the virtual network. Changing this forces a new resource to be created."
  type        = string
}


/*------------------Subnet variable -----------*/
variable "subnet_name" {
  description = "The variable for subnet name"
  type        = list(string)
}

/*------------Private endpoint-------------*/
variable "private_service_connection_name" {
  description = "(Optional) Name of private service connection "
  type        = string
  default     = "rediscache-private-connection"
}
variable "private_dns_zone_name" {
  description = "(Optional) Name of private dns zone"
  type        = string
  default     = "privatelink.redis.cache.windows.net"
}

variable "private_dns_zone_virtual_network_link_name" {
  description = "(Optional) Name of private dns zone_virtual_network_link"
  type        = string
  default     = "private-dns-zone-vnet"
}



/*----------------------------------*/
variable "storage_account_name" {
  description = "(Required) The name must be unique across all existing storage account names in Azure. It must be 3 to 24 characters long, and can contain only lowercase letters and numbers."
  default     = ""
  validation {
    condition     = length(var.storage_account_name) > 3 && length(var.storage_account_name) < 24
    error_message = "Storage account name must be between 3 to 24 letters."
  }

}

variable "account_replication_type" {
  type        = string
  description = "(Required) The Replication type for your Azure Storage. Valid options are LRS, ZRS, GRS, GZRS"
  default     = ""
}

variable "account_tier" {
  type        = string
  description = "(Required)The account tier of storage account. Valid options are Standard or Premium"
  default     = ""
}


variable "account_type" {
  type        = string
  description = "(Optional) Choose an account type that matches your storage needs and optimizes your costs. Valid options are Storage,BlobStorage,BlockBlobStorage,FileStorage,StorageV2"
  default     = ""
  validation {
    condition     = contains(["Storage", "BlobStorage", "BlockBlobStorage", "FileStorage", "StorageV2"], var.account_type)
    error_message = "Account type must Storage,BlobStorage,BlockBlobStorage,FileStorage or StorageV2."
  }
}