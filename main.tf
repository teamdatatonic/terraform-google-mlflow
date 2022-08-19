provider "google" {
  project = var.project_id
}

provider "google-beta" {
  project = var.project_id
}

resource "random_id" "artifacts_bucket_name_suffix" {
  byte_length = 5
}

module "services" {
  source     = "./modules/services"
  project_id = var.project_id
  services = [
    "cloudresourcemanager.googleapis.com",
    "container.googleapis.com",
    "servicenetworking.googleapis.com",
    "stackdriver.googleapis.com",
    "run.googleapis.com",
    "vpcaccess.googleapis.com",
    "sqladmin.googleapis.com",
    "secretmanager.googleapis.com",
    "iap.googleapis.com",
    "cloudbuild.googleapis.com"
  ]
}
module "network" {
  source       = "./modules/network"
  project_id   = var.project_id
  network_name = var.network_name
}

module "mlflow" {
  source                = "./modules/mlflow"
  artifacts_bucket_name = "${var.artifacts_bucket}-${random_id.artifacts_bucket_name_suffix.hex}"
  docker_image_name     = var.mlflow_docker_image
  project_id            = var.project_id
  region                = var.region
  zone                  = var.zone
  network_self_link     = module.network.network_self_link
  network_short_name    = module.network.network_short_name
  create_brand          = var.create_brand
  brand_name            = var.brand_name
  support_email         = var.support_email
  oauth_client_id       = var.oauth_client_id
  oauth_client_secret   = var.oauth_client_secret
  lb_name               = var.lb_name
  domain                = var.domain
  webapp_users          = var.webapp_users
}
