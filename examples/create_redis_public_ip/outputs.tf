output "id" {
  value = module.redis_instance.id
}

output "name" {
  value       = module.redis_instance.name
  description = "The name of the Redis instance."
}

output "host" {
  value       = module.redis_instance.host
  description = "The IP address of the Redis instance."
}

output "port" {
  value       = module.redis_instance.port
  description = "The port of the Redis instance."
}

output "read_endpoint" {
  value       = module.redis_instance.read_endpoint
  description = "The IP address of the Redis instance."
}
output "read_endpoint_port" {
  value       = module.redis_instance.read_endpoint_port
  description = "The port of the Redis instance."
}
