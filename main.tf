data "aws_ssm_parameter" "al2_ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-ebs"
}

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


resource "aws_instance" "rafael-instance-apache" {
  vpc_security_group_ids = aws_security_group.rafael-sg-terraform.id
  ami = data.aws_ami.latest_amazon_linux_2.id
  instance_type = var.ec2_type
  availability_zone = "us-east-1c"
  key_name = aws_key_pair.rafael-terraform-lab.key_name
  tags = var.my_tags
}

resource "aws_key_pair" "rafael-terraform-lab" {
  key_name_prefix =  "rfa-terraform-"
   public_key = var.key-pair
}

