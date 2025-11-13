terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      # because `replica_count` and `read_replicas_mode` require v4.16.0 for `hashicorp/google`, before 4.16.0 need `hashicorp/google-beta`
      version = ">= 4.16.0"
    }
  }
}

resource "google_redis_instance" "cache" {
  name           = replace(var.name, " ", "-")
  tier           = var.tier
  memory_size_gb = var.memory_size
  auth_enabled   = true

  location_id             = "${var.region}-${var.zone}"
  alternative_location_id = var.tier == "STANDARD_HA" ? "${var.region}-${var.alternative_zone}" : ""

  replica_count      = var.replicas
  read_replicas_mode = var.read_replicas_enabled ? "READ_REPLICAS_ENABLED" : "READ_REPLICAS_DISABLED"

  authorized_network = var.network_id
  connect_mode       = "PRIVATE_SERVICE_ACCESS"

  transit_encryption_mode = var.encryption ? "SERVER_AUTHENTICATION" : "DISABLED"


  redis_version     = var.redis_version
  display_name      = var.name
  reserved_ip_range = var.reserved_ip_range != null ? var.reserved_ip_range : null
  secondary_ip_range = var.secondary_ip_range != null ? var.secondary_ip_range : null

  dynamic "maintenance_policy" {
    for_each = var.maintenance == null ? [] : [var.maintenance]
    content {
      weekly_maintenance_window {
        day = upper(maintenance_policy.value.day)
        start_time {
          hours   = maintenance_policy.value.hours
          minutes = maintenance_policy.value.minutes
          seconds = 0
          nanos   = 0
        }
      }
    }
  }

  lifecycle {
    precondition {
      condition     = (var.read_replicas_enabled && var.memory_size >= 5) || var.read_replicas_enabled == false
      error_message = "Read replicas cannot be enabled with less than 5GB of memory."
    }
    precondition {
      condition     = ((var.tier == "BASIC" && var.replicas == 0 && var.read_replicas_enabled == false) || var.tier == "STANDARD_HA")
      error_message = "Read replicas are not supported on the BASIC tier."
    }
    precondition {
      condition = (
        (var.read_replicas_enabled && var.replicas > 0)
        || (!var.read_replicas_enabled && (
          (var.tier == "STANDARD_HA" && var.replicas == 1)
          || (var.tier == "BASIC" && var.replicas == 0)
        ))
      )
      error_message = "Invalid replica configuration: If read replicas are enabled, at least 1 replica is required. If read replicas are disabled, replicas must be 0 for BASIC tier or 1 for STANDARD_HA."
    }
  }
}
