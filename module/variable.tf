locals {
  prefix = "Project17" # change to your desired prefix
}
variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = local.prefix
}