resource "aws_route53_record" "public_delegation" {
  zone_id = var.parent_public_zone_id
  name = var.delegated_domain_name
  type = "NS"
  ttl = var.ttl

  records = var.delegated_public_zone_name_servers
}

resource "aws_route53_record" "private_delegation" {
  zone_id = var.parent_private_zone_id
  name = var.delegated_domain_name
  type = "NS"
  ttl = var.ttl

  records = var.delegated_private_zone_name_servers
}
