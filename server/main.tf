
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

resource "tls_private_key" "rfa-key-lab" {
  algorithm = "RSA"
}

resource "aws_instance" "instance-apache" {
  associate_public_ip_address = true
  subnet_id = aws_subnet.rafael_subnet_pub.id

  vpc_security_group_ids = [aws_security_group.sg-terraform.id]
  ami = data.aws_ami.latest_amazon_linux_2.id
  instance_type = var.ec2_type
  
  key_name = aws_key_pair.rfa-key-pair.key_name
  tags = {
    Name = "${var.prefix}instance"
  }

  user_data = templatefile("${path.module}/scripts/user_data.sh", {
    WELCOME_MSG = var.mensagem
  })
  user_data_replace_on_change = true

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ec2-user"
      private_key = tls_private_key.rfa-key-lab.private_key_pem
    }

    inline = [
      "sudo yum install -y httpd",
      "sudo sh -c 'echo \"Gerado pelo remote-exec\" > /var/www/html/index2.html'",
      "sudo date > /tmp/oi.txt"
    ]
  }
  }

resource "aws_key_pair" "rfa-key-pair" {
 
  key_name_prefix = "${var.prefix}lab"
  public_key = tls_private_key.rfa-key-lab.public_key_openssh

  
}

resource "local_file" "private_key" {
  content = tls_private_key.rfa-key-lab.private_key_pem
  filename = "${var.prefix}lab.pem"
  file_permission = 0400
}

