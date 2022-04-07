terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

module "sql_google_compute_network" {
  source  = "git::https://github.com/honestbank/terraform-gcp-sql.git//modules/google_compute_network?ref=v1.0.2"
  name    = "test-network-terraform"
}

module "redis_instance" {
  source = "../../modules/memstore_redis"

  name   = "redis test instance"
  region = "asia-southeast2"
  zone   = "a"

  redis_version = "REDIS_6_X"

  network_id = module.sql_google_compute_network.id


  reserved_ip_range = "192.168.9.0/28"

  tier = "BASIC"
}
