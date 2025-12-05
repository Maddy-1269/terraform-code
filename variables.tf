output "instance_public_ip" {
  description = "Public IP of created EC2 instance"
  value       = aws_instance.demo_instance.public_ip
}

output "private_key_file" {
  description = "Location of private key PEM file"
  value       = local_file.demo_private_key_pem.filename
  sensitive   = true
}
