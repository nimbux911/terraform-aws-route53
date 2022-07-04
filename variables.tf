variable "zone_name" {
  description = "This is the name of the hosted zone"
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "ID of the VPC to associate"
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to IAM role resources"
  type        = map(string)
  default     = {}
}

variable "record_set" {
  description = "List of maps of DNS records"
  type        = any
  default     = []
}

variable "comment" {
  description = "A comment for the hosted zone"
  type        = string
  default     = ""
}

variable "force_destroy" {
  description = "Whether to destroy all records (possibly managed outside of Terraform) in the zone when destroying the zone"
  type        = bool
  default     = false
}

