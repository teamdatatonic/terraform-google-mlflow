module "mlflow" {
  source  = "teamdatatonic/mlflow/google"
  version = "1.1.0"

  project_id          = var.project_id
  region              = var.region
  zone                = var.zone
  mlflow_docker_image = var.mlflow_docker_image
  network_name        = var.network_name
  brand_name          = var.brand_name
  support_email       = var.support_email
  oauth_client_id     = var.oauth_client_id
  oauth_client_secret = var.oauth_client_secret
  domain              = var.domain
  webapp_users        = var.webapp_users
  storage_uniform     = var.storage_uniform
}
