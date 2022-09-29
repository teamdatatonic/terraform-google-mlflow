variable "artifacts_bucket_name" {
  description = "Name of the bucket to store artifacts"
  type        = string
}

variable "artifacts_bucket_location" {
  description = "Location of the bucket to store artifacts"
  type        = string
  default     = "europe-west2"
}

variable "artifacts_number_version" {
  description = "number of file versions kept in the bucket"
  type        = number
  default     = 1
}

variable "artifacts_storage_class" {
  description = "storage class of the artifacts bucket"
  type        = string
  default     = "STANDARD"
}

variable "db_instance_prefix" {
  description = "prefix of the database instance you want to create"
  type        = string
  default     = "mlflow"
}

variable "db_name" {
  description = "The name of the database instance to create."
  type        = string
  default     = "mlflow_db"
}

variable "db_version" {
  description = "Database instance version to create."
  type        = string
  default     = "POSTGRES_13"
}

variable "db_region" {
  description = "The Google Cloud region in which to provision the database."
  type        = string
  default     = "europe-west2"
}

variable "db_tier" {
  description = "The size of the database instance to create."
  type        = string
  default     = "db-f1-micro"
}

variable "db_availability_type" {
  description = "The type of availability for the database instance."
  type        = string
  default     = "ZONAL"
}

variable "db_username" {
  description = "The username for the database created."
  type        = string
  default     = "mlflowuser"
}

variable "db_password_secret_name" {
  description = "The secret name of the password for the database created."
  type        = string
  default     = "mlflow-db-pwd"
}


variable "docker_image_name" {
  description = "The docker image to use for the mlflow server."
  type        = string
}

variable "project_id" {
  description = "The Google Cloud project ID in which to provision the resources."
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

variable "network_self_link" {
  description = "The self link of the network to use for the database instance.(The private network in ../network)"
  type        = string
}

variable "network_short_name" {
  description = "The short name of the network to use for the database instance.(The private network in ../network)"
  type        = string
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
