terraform {
  backend "s3" {
    bucket       = "thaw-terraform-backend-bucket"
    key          = "dev/test/tf.tfstate"
    region       = "ap-northeast-1"
    profile      = "dev-console-admin"
    use_lockfile = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}


provider "aws" {
  shared_config_files      = var.aws_config_files
  shared_credentials_files = var.aws_credentials_files
  profile                  = var.aws_profile
  region                   = var.aws_region
}
