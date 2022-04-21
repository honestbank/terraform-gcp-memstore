<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.16.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_redis_instance.cache](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/redis_instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alternative_zone"></a> [alternative\_zone](#input\_alternative\_zone) | The location to create the instance in | `string` | n/a | yes |
| <a name="input_encryption"></a> [encryption](#input\_encryption) | Whether to enable encryption | `bool` | `true` | no |
| <a name="input_memory_size"></a> [memory\_size](#input\_memory\_size) | The size of the memory for the instance | `string` | `"2"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the resource | `string` | n/a | yes |
| <a name="input_network_id"></a> [network\_id](#input\_network\_id) | Network id to which to attach the instance(s) | `string` | n/a | yes |
| <a name="input_read_replicas_enabled"></a> [read\_replicas\_enabled](#input\_read\_replicas\_enabled) | Whether to enable read replicas | `bool` | `false` | no |
| <a name="input_redis_version"></a> [redis\_version](#input\_redis\_version) | The version of Redis to use | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region to create the instance in | `string` | `"asia-southeast2"` | no |
| <a name="input_replicas"></a> [replicas](#input\_replicas) | The number of instances to create | `number` | `1` | no |
| <a name="input_reserved_ip_range"></a> [reserved\_ip\_range](#input\_reserved\_ip\_range) | The reserved IP range to use for the instance | `string` | `null` | no |
| <a name="input_tier"></a> [tier](#input\_tier) | The tier of the instance | `string` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | The location to create the instance in | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_auth_string"></a> [auth\_string](#output\_auth\_string) | The auth string of the Redis instance. |
| <a name="output_host"></a> [host](#output\_host) | The IP address of the Redis instance. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Redis instance. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Redis instance. |
| <a name="output_port"></a> [port](#output\_port) | The port of the Redis instance. |
| <a name="output_read_endpoint"></a> [read\_endpoint](#output\_read\_endpoint) | The IP address of the Redis instance. |
| <a name="output_read_endpoint_port"></a> [read\_endpoint\_port](#output\_read\_endpoint\_port) | The port of the Redis instance. |
| <a name="output_server_ca_certificates"></a> [server\_ca\_certificates](#output\_server\_ca\_certificates) | The server CA certificates of the Redis instance (as a list of blocks), return serial\_number, cert, create\_time, expire\_time, sha1\_fingerprint (https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/redis_instance#server_ca_certs). |
<!-- END_TF_DOCS -->
