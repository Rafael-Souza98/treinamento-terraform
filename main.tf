
data "aws_ami" "latest_amazon_linux_2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"] # Filtra as AMIs com esse padrão no nome
  }

  filter {
    name   = "owner-alias"
    values = ["amazon"] # Filtra AMIs cujo proprietário é a Amazon
  }
}
data "aws_availability_zones" "azs" {
  state = "available"
}

module "server1" {
  source          = "./server"
  ami             = data.aws_ami.latest_amazon_linux_2.image_id
  package_name    = "httpd"
  service_name    = "httpd"
  subnet_id = aws_subnet.rafael_subnet_pub.id
  cidr_pub_subnet = local.public_subnet_cidr
  vpc_cidr_block  = aws_vpc.vpc_rafael.cidr_block
  security_group_ids = [aws_security_group.sg-terraform.id]
  
  depends_on = [aws_vpc.vpc_rafael]
}

