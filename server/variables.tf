
variable "vpc_cidr_block" {
  type = string
  default = "192.168.0.0/16"
}

variable "ami" {
  type = string
  
}

variable "ec2_type" {
  type = string
  default = "t2.micro"
}

variable "cidr_pub_subnet" {
  type = string
}

variable "prefix" {
  type = string
  default = "rfa-terraform-"
}


variable "mensagem" {
  type = string
  description = "Mensagem de boas vindas"
  default = "Gerado pelo terraform"
}

