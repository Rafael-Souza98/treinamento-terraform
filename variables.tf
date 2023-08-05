variable "my_tags" {
  type = map(string)
  
}
variable "vpc_cidr_block" {
  type = string
}

variable "ec2_type" {
  type = string
  default = "t2.micro"
}

variable "cidr_pub_subnet" {
  type = string
}

variable "key-pair" {
  type = string
}