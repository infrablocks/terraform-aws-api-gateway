module "api_gateway" {
  source = "../../"

  region = var.region

  component             = var.component
  deployment_identifier = var.deployment_identifier

  domain_name    = var.domain_name
  public_zone_id = var.public_zone_id
  subdomain      = "api.${var.deployment_identifier}"
}
