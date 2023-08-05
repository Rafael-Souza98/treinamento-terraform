resource "aws_vpc" "vpc_rafael" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = var.my_tags
}

resource "aws_subnet" "rafael_subnet_pub" {
    vpc_id = aws_vpc.vpc_rafael.id
    cidr_block = var.cidr_pub_subnet
    map_public_ip_on_launch = true
    tags = var.my_tags
}
resource "aws_internet_gateway" "rfa-igw" {
  vpc_id = aws_vpc.vpc_rafael.id
  tags = var.my_tags
}

resource "aws_route_table" "rfa-rtb" {
  vpc_id = aws_vpc.vpc_rafael.id
  route {
    cidr_block = var.vpc_cidr_block
    gateway_id = aws_internet_gateway.rfa-igw.id
  }
  tags = var.my_tags
}

resource "aws_route_table_association" "this" {
  subnet_id = aws_subnet.rafael_subnet_pub.id
  route_table_id = aws_route_table.rfa-rtb.id
}

resource "aws_security_group" "rafael-sg-terraform" {
  vpc_id = aws_vpc.vpc_rafael.id
  ingress  {
    description      = "Allow ingress protocol TCP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  egress  {
    description = "Allow egress all"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.my_tags
}
  