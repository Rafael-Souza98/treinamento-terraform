locals {
  public_subnet_cidr = cidrsubnet(var.vpc_cidr_block, 8, 0)
}