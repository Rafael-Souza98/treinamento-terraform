output "public_ip" {
  value = module.server1.public_ip
}
output "vpc_id" {
  value = aws_vpc.vpc_rafael.id
}
