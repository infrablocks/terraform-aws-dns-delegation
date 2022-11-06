locals {
  # default for cases when `null` value provided, meaning "use default"
  parent_public_zone_id               = var.parent_public_zone_id == null ? "" : var.parent_public_zone_id
  parent_private_zone_id              = var.parent_private_zone_id == null ? "" : var.parent_private_zone_id
  delegated_public_zone_name_servers  = var.delegated_public_zone_name_servers == null ? [] : var.delegated_public_zone_name_servers
  delegated_private_zone_name_servers = var.delegated_private_zone_name_servers == null ? [] : var.delegated_private_zone_name_servers
  ttl                                 = var.ttl == null ? 172800 : var.ttl
  include_public_delegation_record    = var.include_public_delegation_record == null ? "yes" : var.include_public_delegation_record
  include_private_delegation_record   = var.include_private_delegation_record == null ? "yes" : var.include_private_delegation_record
}
