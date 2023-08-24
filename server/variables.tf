
variable "vpc_cidr_block" {
  type = string
  default = "192.168.0.0/16"
}

variable "subnet_id" {
  type = string
  
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
variable "instance_name" {
  type = string
}

variable "mensagem" {
  type = string
  description = "Mensagem de boas vindas"
  default = "Gerado pelo terraform"
}

variable "package_name" {
  type = string
}

variable "service_name" {
  type = string
}

variable "security_group_ids" {
  type = set(any)
}
