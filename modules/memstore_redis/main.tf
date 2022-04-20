terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

resource "google_redis_instance" "cache" {
  name           = replace(var.name, " ", "-")
  tier           = var.tier
  memory_size_gb = var.memory_size

  auth_enabled = true

  location_id             = "${var.region}-${var.zone}"
  alternative_location_id = "${var.region}-${var.alternative_zone}"

  replica_count      = var.tier == "STANDARD_HA" ? var.replicas : null
  read_replicas_mode = var.read_replicas_enabled ? "READ_REPLICAS_ENABLED" : "READ_REPLICAS_DISABLED"

  authorized_network = var.network_id
  connect_mode       = "PRIVATE_SERVICE_ACCESS"

  transit_encryption_mode = var.encryption ? "SERVER_AUTHENTICATION" : "DISABLED"


  redis_version     = var.redis_version
  display_name      = var.name
  reserved_ip_range = var.reserved_ip_range != null ? var.reserved_ip_range : null

}
