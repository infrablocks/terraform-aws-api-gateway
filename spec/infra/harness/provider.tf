provider "aws" {
  region = var.region
  version = "2.7"
}

provider "aws" {
  region = "us-east-1"
  version = "2.7"
  alias = "useast1"
}
