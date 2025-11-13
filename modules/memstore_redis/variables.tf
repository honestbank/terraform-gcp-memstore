variable "name" {
  description = "The name of the resource"
  type        = string
}

variable "tier" {
  type        = string
  description = "The tier of the instance"

  validation {
    condition     = contains(["STANDARD_HA", "BASIC"], var.tier)
    error_message = "Allowed values for tier are \"STANDARD_HA\" and \"BASIC\"."
  }
}

variable "network_id" {
  type        = string
  description = "Network id to which to attach the instance(s)"
}

variable "region" {
  type        = string
  default     = "asia-southeast2"
  description = "The region to create the instance in"
}

variable "zone" {
  type        = string
  description = "The location to create the instance in"
}

variable "alternative_zone" {
  type        = string
  description = "The location to create the instance in"
}

variable "reserved_ip_range" {
  type        = string
  default     = null
  description = "The reserved IP range to use for the instance"
}

variable "secondary_ip_range" {
  type        = string
  default     = null
  description = "The secondary IP range to use for the instance"
}

variable "memory_size" {
  type        = string
  default     = "2"
  description = "The size of the memory for the instance"
}

variable "replicas" {
  type        = number
  default     = 0
  description = "The number of read replicas to create"
  validation {
    condition     = var.replicas <= 5
    error_message = "The valid range for the Standard Tier with read replicas enabled is [1-5] and defaults to 0 as the default is zero read-replicas."
  }
}

variable "read_replicas_enabled" {
  type        = bool
  default     = false
  description = "Whether to enable read replicas"
}

variable "redis_version" {
  type        = string
  description = "The version of Redis to use"
}

variable "encryption" {
  type        = bool
  default     = true
  description = "Whether to enable encryption"
}

variable "maintenance" {
  description = "Optional weekly maintenance window (UTC). Omit to let GCP choose."
  type = object({
    day     = string # e.g., "MONDAY"
    hours   = number # 0..23
    minutes = number # 0..59
  })
  default = null

  validation {
    condition = var.maintenance == null || (
      contains(["MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY", "SATURDAY", "SUNDAY"], upper(var.maintenance.day)) &&
      var.maintenance.hours >= 0 && var.maintenance.hours <= 23 &&
      var.maintenance.minutes >= 0 && var.maintenance.minutes <= 59
    )
    error_message = "maintenance: day must be MONDAY..SUNDAY; time must be a valid UTC time."
  }
}
