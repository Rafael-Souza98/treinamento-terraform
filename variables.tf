
variable "vpc_cidr_block" {
  type = string
}

variable "ec2_type" {
  type    = string
  default = "t2.micro"
}

variable "cidr_pub_subnet" {
  type = string
}


variable "prefix" {
  type = string
}

variable "iam_role_instance" {
  type = string
}
variable "mensagem" {
  type        = string
  description = "Mensagem de boas vindas"
}