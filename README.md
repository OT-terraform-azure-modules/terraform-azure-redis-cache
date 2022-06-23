Terraform module which creates Redis Cache on Azure.

These types of resources are supported:

* [Azure Cache for Redis](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/redis_cache)

Terraform versions
------------------
Terraform 1.1.7

Usage
------

```hcl
module "res_group" {
  source                  = "OT-terraform-azure-modules/resource-group/azure"
  resource_group_name     = "_"
  resource_group_location = "_"
  lock_level_value        = "_"
  tag_map = {
    Name = "AzureResourceGroup"
  }
}

module "redis" {
  source                        = "git::https://github.com/OT-terraform-azure-modules/terraform-azure-redis-cache.git"
  rg_name                       = module.res_group.resource_group_name
  location                      = module.res_group.resource_group_location
  redis_name                    = "_"
  capacity                      = "_"
  family                        = "_"
  sku_name                      = "_"
  enable_non_ssl_port           = "_"
  minimum_tls_version           = "_"
  private_static_ip_address     = "_"
  public_network_access_enabled = "_"
  replicas_per_master           = "_"
  shard_count                   = "_"
  subnet_id                     = "_"
  zones                         = ["_","_"]
  replicas_per_primary          = "_"
  redis_version                 = "_"
  enable_authentication           = "_"
  maxfragmentationmemory_reserved = "_"
  maxmemory_delta                 = "_"
  maxmemory_policy                = "_"
  maxmemory_reserved              = "_"
  notify_keyspace_events          = "_"
  day_of_week                     = "_"
  start_hour_utc                  = "_"
}

```

Tags
----
* Tags are assigned to resources with name variable as prefix.
* Additial tags can be assigned by tags variables as defined above.

Resources
------
| Name | Type |
|------|------|
| [azurerm_redis_cache.redis](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/redis_cache) | resource |

Inputs
------
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| vnet_name | The name of the virtual network. Changing this forces a new resource to be created. | `string` |  | Yes |
| resource_group_name | The name of the resource group in which to create the virtual network. | `string` |  | Yes |
| resource_group_location | The location/region where the virtual network is created. Changing this forces a new resource to be created. | `string` |  | yes |
| redis_name | The name of the Redis instance. Changing this forces a new resource to be created. | `string` |  | yes |
| capacity | The size of the Redis cache to deploy. | `number` |  | yes |
| family | The SKU family/pricing group to use. | `string` |  | yes |
| sku_name | The SKU of Redis to use. | `string` |  | yes |
| enable_non_ssl_port | Enable the non-SSL port (6379). | `bool` | false | no |
| minimum_tls_version | The minimum TLS version. | `string` | 1.0 | no |
| private_static_ip_address | The Static IP Address to assign to the Redis Cache when hosted inside the Virtual Network. | `string` |  | no |
| public_network_access_enabled | Whether or not public network access is allowed for this Redis Cache. | `bool` | true | no |
| replicas_per_master | Amount of replicas to create per master for this Redis Cache. | `number` |  | no |
| shard_count | The number of Shards to create on the Redis Cluster. | `number` |  | no |
| subnet_id | The ID of the Subnet within which the Redis Cache should be deployed. | `list(string)` |   | no |
| zones | A list of a one or more Availability Zones, where the Redis Cache should be allocated.  | `list(string)` |  | no |
| replicas_per_primary | Amount of replicas to create per primary for this Redis Cache. | `number` |  | no |
| redis_version | Redis version. Only major version needed. | `number` |  | no |
| enable_authentication | If set to false, the Redis instance will be accessible without authentication. | `bool` | true | no |
| maxfragmentationmemory_reserved | Value in megabytes reserved to accommodate for memory fragmentation. | `number` |  | no |
| maxmemory_delta | The max-memory delta for this Redis instance. | `number` |  | no |
| maxmemory_reserved | Value in megabytes reserved for non-cache usage e.g. failover. | `number` |  | no |
| maxmemory_policy | How Redis will select what to remove when maxmemory is reached. | `string` |   | no |
| notify_keyspace_events | Keyspace notifications allows clients to subscribe to Pub/Sub channels in order to receive events | `string` |   | no |
| day_of_week | the Weekday name - possible values include Monday, Tuesday, Wednesday etc. | `string` |   | no |
| start_hour_utc | the Start Hour for maintenance in UTC - possible values range from 0 - 23. | `number` |  | no |
| tag_map | Tag to associate with the Resource Group | `map(string)` | | no |

Output
------
| Name | Description |
|------|-------------|
| redis_id | The Route ID of Redis Cache Instance |
| hostname | The Hostname of the Redis Instance |
| ssl_port | The SSL Port of the Redis Instance |
| port | The non-SSL Port of the Redis Instance |
| primary_access_key | The Primary Access Key for the Redis Instance |
| secondary_access_key | The Secondary Access Key for the Redis Instance |
| primary_connection_string | The primary connection string of the Redis Instance |
| secondary_connection_string | The secondary connection string of the Redis Instance |

## Related Projects

Check out these related projects.
--------------------------------
[Azure reource group](https://github.com/OT-terraform-azure-modules/terraform-azure-resource-group)


### Contributors
|  [![Akash Banerjee][Akash_avatar]][Akash.s_homepage]<br/>[Akash Banerjee][Akash.s_homepage] |
|---|
 
  [Akash.s_homepage]:https://github.com/401-akash
  [Akash_avatar]: https://gitlab.com/uploads/-/system/user/avatar/10949531/avatar.png?width=400