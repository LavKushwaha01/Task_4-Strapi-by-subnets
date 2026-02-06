resource "aws_instance" "bastion" {
  ami                         = "ami-0fc5d935ebf8bc3bc"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  key_name                    = aws_key_pair.generated_key.key_name
  associate_public_ip_address = true

  tags = {
    Name = "bastion-host"
  }
}
