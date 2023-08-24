resource "aws_vpc" "vpc_rafael" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = {
    Name = "${var.prefix}vpc_lab"
  }
}

resource "aws_subnet" "rafael_subnet_pub" {

  vpc_id                  = aws_vpc.vpc_rafael.id
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 8, 0)
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.prefix}subnet-pub-lab"

  }
}
resource "aws_internet_gateway" "terraform-igw" {

  vpc_id = aws_vpc.vpc_rafael.id
  tags = {
    Name = "${var.prefix}igw-lab"

  }
}

resource "aws_route_table" "rfa-rtb" {
  vpc_id = aws_vpc.vpc_rafael.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform-igw.id
  }
  tags = {
    Name = "${var.prefix}route-table"
  }
}

resource "aws_route_table_association" "this" {

  subnet_id      = aws_subnet.rafael_subnet_pub.id
  route_table_id = aws_route_table.rfa-rtb.id
}

resource "aws_security_group" "sg-terraform" {

  name   = "${var.prefix}sg-web"
  vpc_id = aws_vpc.vpc_rafael.id

  dynamic "ingress" {

    for_each = var.ports_ingress

    content {
      description = "Permitem trafego de entrada na porta ${ingress.value}"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks  = ["0.0.0.0/0"]

    }
  }
  egress {
      description = "Allow egress all"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "sg-terraform-db" {

  name   = "${var.prefix}sg-db"
  vpc_id = aws_vpc.vpc_rafael.id

  dynamic "ingress" {

    for_each = var.ports_ingress

    content {
      description = "Permitem trafego de entrada na porta ${ingress.value}"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks  = ["0.0.0.0/0"]

    }
  }

   egress {
      description = "Allow egress all"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
}
  