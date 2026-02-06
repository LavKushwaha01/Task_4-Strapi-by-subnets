resource "aws_instance" "strapi" {
  ami                         = "ami-0fc5d935ebf8bc3bc" 
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  key_name                    = aws_key_pair.generated_key.key_name
  associate_public_ip_address = false

  user_data = file("${path.module}/user_data.sh")

  tags = {
    Name = "strapi-private-ec2"
    Env  = "dev"
  }
}
