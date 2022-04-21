output "id" {
  value       = google_redis_instance.cache.id
  description = "The ID of the Redis instance."
}

output "name" {
  value       = google_redis_instance.cache.name
  description = "The name of the Redis instance."
}

output "host" {
  value       = google_redis_instance.cache.host
  description = "The IP address of the Redis instance."
}

output "port" {
  value       = google_redis_instance.cache.port
  description = "The port of the Redis instance."
}

output "read_endpoint" {
  value       = google_redis_instance.cache.read_endpoint
  description = "The IP address of the Redis instance."
}
output "read_endpoint_port" {
  value       = google_redis_instance.cache.read_endpoint_port
  description = "The port of the Redis instance."
}

output "server_ca_certificates" {
  value       = google_redis_instance.cache.server_ca_certs
  description = "The server CA certificates of the Redis instance."
}

output "auth_string" {
  value       = google_redis_instance.cache.auth_string
  description = "The auth string of the Redis instance."
}
