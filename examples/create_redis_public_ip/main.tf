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
  #checkov:skip=CKV_TF_1:We use the version tag instead of the commit hash
  #checkov:skip=CKV2_GCP_18:We ignore the creation of firewall rules
  source = "git::https://github.com/honestbank/terraform-gcp-sql.git//modules/google_compute_network?ref=v1.1.1"
  name   = "test-redis-terraform-${random_id.instance_suffix.hex}"
}

module "google_compute_global_address_private_ip_address" {
  #checkov:skip=CKV_TF_1:We use the version tag instead of the commit hash
  source = "git::https://github.com/honestbank/terraform-gcp-sql.git//modules/google_compute_global_address?ref=v1.1.1"

  name          = "redis-pip-${random_id.instance_suffix.hex}"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = module.private_network.id
}

module "google_service_networking_connection_private_vpc_connection" {
  #checkov:skip=CKV_TF_1:We use the version tag instead of the commit hash
  source = "git::https://github.com/honestbank/terraform-gcp-sql.git//modules/google_service_networking_connection?ref=v1.1.1"

  network                 = module.private_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [module.google_compute_global_address_private_ip_address.name]
}

module "redis_instance" {
  source      = "../../modules/memstore_redis"
  memory_size = 5

  depends_on = [module.google_service_networking_connection_private_vpc_connection]

  name                  = "redis-test-${random_id.instance_suffix.hex}"
  region                = "asia-southeast2"
  zone                  = "a"
  alternative_zone      = "b"
  redis_version         = "REDIS_6_X"
  network_id            = module.private_network.id
  tier                  = "STANDARD_HA"
  replicas              = 1
  read_replicas_enabled = true
}
