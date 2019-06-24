provider "aws" {
  region  = "${var.region}"
  version = "2.0"
}

provider "aws" {
  region  = "us-east-1"
  version = "2.0"
  alias   = "useast1"
}
