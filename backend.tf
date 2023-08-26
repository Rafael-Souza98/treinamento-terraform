terraform {
  backend "s3" {
    bucket         = "rfa-state-terraform"
    key            = "dev/rfa-terraform.tfstate"
    region         = "us-east-1"
    profile        = "rafael-terraform-lab"
    dynamodb_table = "state-terraform-rfa"
  }
}