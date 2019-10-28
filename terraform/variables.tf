variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}

variable "region" {
  description = "Region in which to birth the resources"
  default     = "us-phoenix-1"
}

variable "project_name" {
  description = "Project name used for the names of stuff"
  default     = "freeloading_bastard"
}

variable "project_short_name" {
  description = "Project short name for things like DB names"
  default     = "flb"
}

variable "cidr_block" {
  description = "CIDR block for the VCN"
  default     = "10.6.66.0/16"
}
