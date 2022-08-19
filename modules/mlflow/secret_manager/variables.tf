variable "secret_id" {
  description = "Name of the secret you want to create"
  type        = string
}

variable "module_depends_on" {
  description = "modules that this module depends on"
  type        = any
  default     = null
}
