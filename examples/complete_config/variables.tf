variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "The Google Cloud region in which to provision the resources."
  type        = string
}

variable "zone" {
  description = "The Google Cloud zone in which to provision the resources."
  type        = string
}

variable "artifacts_bucket" {
  description = "GCP bucket to store artifacts"
  type        = string
  default     = "mlflow-artifacts-store"
}

variable "mlflow_docker_image" {
  description = "Docker image to use for MLflow"
  type        = string
}

variable "network_name" {
  description = "if you have a prefered network to use enter it if not leave it empty one will be created for you"
  type        = string
}

variable "storage_uniform" {
  description = "Uniform access level to be activated for the buckets"
  type        = string
}

variable "create_brand" {
  description = "1 if the brand needs to be created, 0 otherwise"
  type        = number
}

variable "brand_name" {
  description = "The name of the brand if it exists (Leave blank if you entered 1 for the create_brand variable)"
  type        = string
}
variable "support_email" {
  description = "Person or group to contact in case of problems"
}

variable "oauth_client_id" {
  description = "The OAuth client ID (Leave blank if you entered 1 for the create_brand variable)"
  type        = string
}
variable "oauth_client_secret" {
  description = "The OAuth client secret (Leave blank if you entered 1 for the create_brand variable)"
  type        = string
}
variable "lb_name" {
  description = "The name of the load balancer"
  type        = string
  default     = "mlflow-lb"
}
variable "domain" {
  description = "The domain name to run the load balancer on"
  type        = string
}

variable "webapp_users" {
  description = "List of people who can acess the mlflow web app. e.g. [user:jane@example.com, group:people@example.com]"
  type        = list(string)
}
