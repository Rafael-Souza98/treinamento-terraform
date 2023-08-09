
data "aws_ami" "latest_amazon_linux_2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]  # Filtra as AMIs com esse padrão no nome
  }

  filter {
    name   = "owner-alias"
    values = ["amazon"]  # Filtra AMIs cujo proprietário é a Amazon
  }
}

module "server1" {
  source = "./server"
  ami = data.aws_ami.latest_amazon_linux_2
  cidr_pub_subnet = local.public_subnet_cidr
  vpc_cidr_block = var.vpc_cidr_block
  depends_on = [ aws_vpc.vpc_rafael ]

}
