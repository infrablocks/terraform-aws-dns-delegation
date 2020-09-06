variable "parent_public_zone_id" {
  type = string
  description = "The public zone ID hosting the parent domain name."
}

variable "parent_private_zone_id" {
  type = string
  description = "The private zone ID hosting the parent domain name."
}

variable "delegated_public_zone_name_servers" {
  type = list(string)
  description = "The name servers of the public hosted zone hosting the delegated domain name."
}

variable "delegated_private_zone_name_servers" {
  type = list(string)
  description = "The name servers of the private hosted zone hosting the delegated domain name."
}

variable "delegated_domain_name" {
  type = string
  description = "The domain name to be delegated."
}

variable "ttl" {
  type = number
  default = 172800
  description = "The TTL of the created records."
}

variable "include_public_delegation_record" {
  type = string
  default = "yes"
  description = "Whether or not to create a delegation record in the public hosted zone (\"yes\" or \"no\"). Defaults to \"yes\"."
}

variable "include_private_delegation_record" {
  type = string
  default = "yes"
  description = "Whether or not to create a delegation record in the private hosted zone (\"yes\" or \"no\"). Defaults to \"yes\"."
}
