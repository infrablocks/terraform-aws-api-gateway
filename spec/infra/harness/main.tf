data "terraform_remote_state" "prerequisites" {
  backend = "local"

  config = {
    path = "${path.module}/../../../../state/prerequisites.tfstate"
  }
}

module "api_gateway" {
  # This makes absolutely no sense. I think there's a bug in terraform.
  source = "./../../../../../../../"

  region = var.region

  component = var.component
  deployment_identifier = var.deployment_identifier

  domain_name = var.domain_name
  subdomain = var.subdomain
  public_zone_id = var.public_zone_id

  create_custom_domain = var.create_custom_domain
  create_certificate = var.create_certificate
}
