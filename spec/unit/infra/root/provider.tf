provider "aws" {
  region = var.region
}

provider "aws" {
  region = "us-east-1"
  alias = "useast1"
}
