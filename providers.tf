terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.13.1"
    }
  }

  backend "s3" {
    bucket         = "myapp-s3-bucket"
    key            = "state/terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
  }
}

provider "aws" {
  region = "eu-central-1"
}

