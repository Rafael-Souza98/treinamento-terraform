terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.11.0"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "4.0.4"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "rafael-terraform-lab"
  default_tags {
    tags = {
      Owner =              "rafael"
      Environment = "dev"
      ManegedBy   = "Terraform"
    }
  }
}

