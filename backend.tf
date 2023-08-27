terraform {
  backend "s3" {
    bucket         = "rfa-state-terraform"
    key            = "dev/rfa-terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "state-terraform-rfa"
  }
}