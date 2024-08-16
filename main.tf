provider "aws" {
  region = "ap-northeast-1"
}

terraform {
  backend "s3" {
    bucket         = "tora-local-terraform-running-state"
    key            = "global/s3/terraform.tfstate"
    region         = "ap-northeast-1"
    dynamodb_table = "terraform-up-and-runnning-locks"
    encrypt        = true
  }
}