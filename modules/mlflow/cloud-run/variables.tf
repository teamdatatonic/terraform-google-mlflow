
variable "project_id" {
  description = "The Google Cloud project ID in which to provision the resources."
  type        = string
}

variable "region" {
  description = "The Google Cloud region in which to provision the resources."
  type        = string
}

variable "docker_image_name" {
  description = "The name of the docker image"
  type        = string
}
variable "db_instance" {
  description = "The name of the database instance"
  type        = string
}

variable "db_name" {
  description = "The name of the database"
  type        = string
}

variable "db_username" {
  description = "The user name for the database"
  type        = string
}

variable "db_password" {
  description = "The password for the database"
  type        = string
}

variable "db_private_ip" {
  description = "The private IP of the database instance"
  type        = string
}

variable "gcs_backend" {
  description = "GCS bucket used for arifacts"
  type        = string
}

variable "module_depends_on" {
  description = "The dependencies of the module"
  type        = any
  default     = null
}

variable "network_short_name" {
  type = string
}

variable "brand_name" {
  description = "The name of the brand"
  type        = string
}
variable "support_email" {
  description = "Person or group to contact in case of problems"
}

variable "oauth_client_id" {
  description = "The OAuth client ID"
  type        = string
}
variable "oauth_client_secret" {
  description = "The OAuth client secret"
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

variable "logger_email" {
  description = "The email address of the logger service account"
  type        = string
}
