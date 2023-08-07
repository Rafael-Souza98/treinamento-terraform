 
output "ami_id" {
  value = aws_instance.instance-apache.id
}

output "public_ip" {
  value = aws_instance.instance-apache.public_ip
}

output "private_ip" {
  value = aws_instance.instance-apache.private_ip
} 

output "iam_profile" {
  value = aws_iam_instance_profile.this
}
