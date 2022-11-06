data "aws_vpc" "default" {
  default = true
}

module "parent_dns_zones" {
  source = "infrablocks/dns-zones/aws"
  version = "1.0.0"

  domain_name = var.parent_domain_name
  private_domain_name = var.parent_domain_name

  private_zone_vpc_id = data.aws_vpc.default.id
  private_zone_vpc_region = var.region
}

module "delegated_dns_zones" {
  source = "infrablocks/dns-zones/aws"
  version = "1.0.0"

  domain_name = var.delegated_domain_name
  private_domain_name = var.delegated_domain_name

  private_zone_vpc_id = data.aws_vpc.default.id
  private_zone_vpc_region = var.region
}
