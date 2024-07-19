locals {
  # Generate invalid values to be used so that the module fails based on composite
  # scenarios as validation conditions only apply to the variable scoped for the
  # validation condition.
  memory_size   = var.read_replicas_enabled && var.memory_size >= 5 ? var.memory_size : 0
  replicas      = var.tier == "STANDARD_HA" ? var.replicas : 0
  replica_count = var.read_replicas_enabled && local.replicas > 0 ? var.replicas : 0
}
