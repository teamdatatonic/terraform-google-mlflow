variable "project_id" {
  description = "The Google Cloud project ID"
  type        = string
}

variable "services" {
  description = "list of services to enable"
  type        = list(string)
}
