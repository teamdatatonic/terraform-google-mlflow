variable "project_id" {
  description = "GCP project ID"
  type        = string
}
variable "bucket_name" {
  description = "The name of the bucket to store MLflow artifacts"
  type        = string
}
variable "bucket_location" {
  description = "location of the bucket"
  type        = string
}

variable "versioning_enabled" {
  description = "enable versioning on the bucket"
  type        = bool
  default     = true
}

variable "number_of_versions" {
  description = "number of versions to keep with the versioning"
  type        = number
  default     = 3
}

variable "storage_class" {
  description = "Storage class for the bucket"
  type        = string
}

variable "storage_uniform" {
  description = "Uniform access level to be activated for the buckets"
  type        = bool
  default     = true
}

variable "module_depends_on" {
  description = "module that this module depends on"
  type        = any
  default     = null
}
