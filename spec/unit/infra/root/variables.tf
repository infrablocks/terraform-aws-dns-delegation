variable "region" {}

variable "delegated_domain_name" {}

variable "ttl" {
  type = number
  default = null
}

variable "include_public_delegation_record" {
  default = null
}
variable "include_private_delegation_record" {
  default = null
}
