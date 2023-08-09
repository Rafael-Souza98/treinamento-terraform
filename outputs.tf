output "public_ip" {
  value = module.server1.public_ip

}

output "private_ip" {
  value = module.server1.private_ip
}

output "ami_id" {
  value = module.server1.ami_id
}