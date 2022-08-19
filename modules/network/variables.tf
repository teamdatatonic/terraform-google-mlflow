variable "project_id" {
  description = "GCP project ID"
  type        = string
}
variable "network_name" {
  description = "The name of the Google Cloud network to attach to. If null a new network will be created"
  type        = string
}

variable "network_name_local" {
  description = "The name of the network to create if network_name is null"
  type        = string
  default     = "mlflow-network"
}
