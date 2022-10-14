locals {
  address = lower("${var.subdomain}.${var.domain_name}")
}
