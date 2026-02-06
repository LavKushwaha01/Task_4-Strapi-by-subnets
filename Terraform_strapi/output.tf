output "alb_dns_name" {
  description = "Public URL of the Application Load Balancer"
  value       = aws_lb.alb.dns_name
}

output "bastion_public_ip" {
  description = "Public IP of Bastion Host"
  value       = aws_instance.bastion.public_ip
}

output "private_ec2_ip" {
  description = "Private IP of Strapi EC2 instance"
  value       = aws_instance.strapi.private_ip
}
