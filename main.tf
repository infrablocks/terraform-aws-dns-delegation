resource "aws_route53_record" "public_delegation" {
  count = local.include_public_delegation_record == "yes" ? 1 : 0

  zone_id = local.parent_public_zone_id
  name = var.delegated_domain_name
  type = "NS"
  ttl = local.ttl

  records = local.delegated_public_zone_name_servers
}

resource "aws_route53_record" "private_delegation" {
  count = local.include_private_delegation_record == "yes" ? 1 : 0

  zone_id = local.parent_private_zone_id
  name = var.delegated_domain_name
  type = "NS"
  ttl = local.ttl

  records = local.delegated_private_zone_name_servers
}
