terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}


resource "random_id" "instance_suffix" {
  byte_length = 4
}

module "private_network" {
  source = "git::https://github.com/honestbank/terraform-gcp-sql.git//modules/google_compute_network?ref=v1.0.2"
  name   = "test-network-terraform"
}

module "google_compute_global_address_private_ip_address" {
  source = "git::https://github.com/honestbank/terraform-gcp-sql.git//modules/google_compute_global_address?ref=v1.0.2"

  name          = "private-ip-address-${random_id.instance_suffix.hex}"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = module.private_network.id
}

module "redis_instance" {
  source = "../../modules/memstore_redis"

  name          = "redis test instance"
  region        = "asia-southeast2"
  zone          = "a"
  redis_version = "REDIS_6_X"
  network_id    = module.private_network.id
  tier          = "BASIC"
}
