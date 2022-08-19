variable "project_id" {
  description = "GCP project ID"
  type        = string
}
variable "instance_prefix" {
  description = "name of database instance you want to create"
  type        = string
  default     = "mlflow"
}

variable "db_name" {
  description = "The name of the database instance to create."
  type        = string
  default     = "mlflow_db"
}

variable "db_version" {
  description = "The version of the database to create."
  type        = string
  default     = "POSTGRES_13"
}

variable "db_tier" {
  description = "The tier of the database to create."
  type        = string
  default     = "df-f1-micro"
}

variable "region" {
  description = "The Google Cloud region in which to provision the resources."
  type        = string
  default     = "europe-west2"
}

variable "availability_type" {
  description = "The type of availability for the database instance."
  type        = string
  default     = "ZONAL"
}

variable "username" {
  description = "The username for the database created."
  type        = string
}

variable "password" {
  description = "The password for the database created."
  type        = string
}

variable "module_depends_on" {
  description = "module that this module depends on"
  type        = any
  default     = null
}

variable "network_self_link" {
  description = "The self link of the network to use for the database instance.(The private network in ../network)"
  type        = string
}
