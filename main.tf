
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
data "aws_iam_role" "iam_role_instance" {
  name = "AmazonSSMRoleForInstancesQuickSetup"
}


resource "aws_instance" "instance-apache" {
  associate_public_ip_address = true
  subnet_id = aws_subnet.rafael_subnet_pub.id
  iam_instance_profile = data.aws_iam_role.iam_role_instance.name
  vpc_security_group_ids = [aws_security_group.sg-terraform.id]
  ami = data.aws_ami.latest_amazon_linux_2.id
  instance_type = var.ec2_type
  
  key_name = aws_key_pair.rafael-terraform-lab.key_name
  tags = {
    Name = "${var.prefix}instance-apache"
  }
}

resource "aws_key_pair" "rafael-terraform-lab" {
 
  key_name_prefix =  var.prefix
   public_key = var.key-pair
}

resource "aws_iam_instance_profile" "this" {
  name = "${var.prefix}instance-profile"
  role = var.iam_role_instance
}