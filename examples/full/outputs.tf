output "parent_public_zone_id" {
  value = module.parent_dns_zones.public_zone_id
}

output "parent_public_zone_name_servers" {
  value = module.parent_dns_zones.public_zone_name_servers
}

output "parent_private_zone_id" {
  value = module.parent_dns_zones.private_zone_id
}

output "parent_private_zone_name_servers" {
  value = module.parent_dns_zones.private_zone_name_servers
}

output "delegated_public_zone_id" {
  value = module.delegated_dns_zones.public_zone_id
}

output "delegated_public_zone_name_servers" {
  value = module.delegated_dns_zones.public_zone_name_servers
}

output "delegated_private_zone_id" {
  value = module.delegated_dns_zones.private_zone_id
}

output "delegated_private_zone_name_servers" {
  value = module.delegated_dns_zones.private_zone_name_servers
}
