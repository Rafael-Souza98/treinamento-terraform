
variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "ec2_type" {
  type    = string
  default = "t2.micro"
}


variable "ports_ingress" {
  type    = list(number)
  default = [80, 443, 22]
}

variable "prefix" {
  type    = string
  default = "rafael-terraform"
}

variable "mensagem" {
  type        = string
  description = "Mensagem de boas vindas"
  default     = "funfou"
}