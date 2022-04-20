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


variable "memory_size" {
  type        = string
  default     = "2"
  description = "The size of the memory for the instance"
}

variable "replicas" {
  type        = number
  default     = 1
  description = "The number of instances to create"
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
