module "artifacts" {
  source             = "./artifacts"
  project_id         = var.project_id
  bucket_name        = var.artifacts_bucket_name
  bucket_location    = var.artifacts_bucket_location
  number_of_versions = var.artifacts_number_version
  storage_class      = var.artifacts_storage_class
}

module "db_secret" {
  source    = "./secret_manager"
  secret_id = var.db_password_secret_name
}

module "database" {
  source            = "./database"
  project_id        = var.project_id
  instance_prefix   = var.db_instance_prefix
  db_version        = var.db_version
  region            = var.db_region
  db_tier           = var.db_tier
  availability_type = var.db_availability_type
  db_name           = var.db_name
  username          = var.db_username
  password          = module.db_secret.secret_value
  network_self_link = var.network_self_link
}

module "logger" {
  source = "./logger"
  # location = module.cloud_run.service_location
  project_id = var.project_id
  # service_name = module.cloud_run.service_name
  artifacts_bucket = module.artifacts.name
}

module "cloud_run" {
  source              = "./cloud-run"
  project_id          = var.project_id
  region              = var.region
  docker_image_name   = var.docker_image_name
  db_instance         = module.database.instance_connection_name
  db_name             = var.db_name
  db_username         = var.db_username
  db_password         = module.db_secret.secret_value
  db_private_ip       = module.database.private_ip
  gcs_backend         = module.artifacts.url
  network_short_name  = var.network_short_name
  brand_name          = var.brand_name
  support_email       = var.support_email
  domain              = var.domain
  webapp_users        = var.webapp_users
  oauth_client_id     = var.oauth_client_id
  oauth_client_secret = var.oauth_client_secret
  logger_email        = module.logger.logger_email
}
