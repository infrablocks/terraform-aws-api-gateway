provider "aws" {
  region = "${var.region}"
}

provider "aws" {
  region  = "us-east-1"
  version = "2.7"
  alias   = "useast1"
}
