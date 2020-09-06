data "terraform_remote_state" "prerequisites" {
  backend = "local"

  config = {
    path = "${path.module}/../../../../state/prerequisites.tfstate"
  }
}

module "dns_delegation" {
  source = "../../../../"

  parent_public_zone_id = data.terraform_remote_state.prerequisites.outputs.parent_public_zone_id
  parent_private_zone_id = data.terraform_remote_state.prerequisites.outputs.parent_private_zone_id

  delegated_public_zone_name_servers = data.terraform_remote_state.prerequisites.outputs.delegated_public_zone_name_servers
  delegated_private_zone_name_servers = data.terraform_remote_state.prerequisites.outputs.delegated_private_zone_name_servers

  delegated_domain_name = var.delegated_domain_name

  include_public_delegation_record = var.include_public_delegation_record
  include_private_delegation_record = var.include_private_delegation_record
}
