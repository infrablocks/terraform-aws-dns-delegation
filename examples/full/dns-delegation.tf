module "dns_delegation" {
  source = "../../"

  parent_public_zone_id  = module.parent_dns_zones.public_zone_id
  parent_private_zone_id = module.parent_dns_zones.private_zone_id

  delegated_public_zone_name_servers  = module.delegated_dns_zones.public_zone_name_servers
  delegated_private_zone_name_servers = module.delegated_dns_zones.private_zone_name_servers

  delegated_domain_name = var.delegated_domain_name

  ttl = 86400
}
