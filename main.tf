
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
  source = "./server"
  ami    = data.aws_ami.latest_amazon_linux_2.image_id

  for_each           = local.servidores
  instance_name      = "${var.prefix}-${each.key}"
  package_name       = each.value.package_name
  service_name       = each.value.service_name
  subnet_id          = aws_subnet.rafael_subnet_pub.id
  cidr_pub_subnet    = cidrsubnet(aws_vpc.vpc_rafael.cidr_block, 8, 0)
  vpc_cidr_block     = aws_vpc.vpc_rafael.cidr_block
  security_group_ids = [aws_security_group.sg-terraform.id]

  depends_on = [aws_vpc.vpc_rafael]
}

resource "aws_security_group" "allow_tls" {
  for_each = local.ingress_ports

  name        = "${var.prefix}-${each.key}-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc_rafael.id

  dynamic "ingress" {
    for_each = each.value

    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = [ingress.value.source]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "${var.prefix}-sg"
  }
}

resource "aws_db_instance" "db-rafael" {
  instance_class = "db.t3.micro"

  db_subnet_group_name = "default-vpc-08cd1341b8b63ae43"
  engine               = "mysql"

  identifier                   = "db-import-terraform"
  parameter_group_name         = "default.mysql8.0"
  performance_insights_enabled = false
  port                         = 3306
  publicly_accessible          = true
  skip_final_snapshot          = true
  vpc_security_group_ids       = ["sg-0af9b87c132122a96", ]
  username                     = "admin"
  tags_all = {
    "Environment" = "dev"
    "ManegedBy"   = "Terraform"
    "Owner"       = "rafael"
  }
}

resource "aws_s3_bucket" "import-bucket-rafael" {
  bucket = "rafael-import-bucket"
  force_destroy = false
  object_lock_enabled = false
  tags_all = {
    "Environment" = "dev"
    "ManegedBy"   = "Terraform"
    "Owner"       = "rafael"
  }
}

