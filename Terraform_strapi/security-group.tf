# ALB Security Group (Public HTTP)
resource "aws_security_group" "alb_sg" {
  name   = "alb-sg"
  vpc_id = aws_vpc.main.id

  dynamic "ingress" {
    for_each = var.alb_ports
    iterator = port
    content {
      description = "Allow HTTP from internet"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Security Group (Private Instance)
resource "aws_security_group" "ec2_sg" {
  name   = "strapi-ec2-sg"
  vpc_id = aws_vpc.main.id

  # App traffic only from ALB
  dynamic "ingress" {
    for_each = var.ec2_ports
    iterator = port
    content {
      description     = "Allow Strapi from ALB"
      from_port       = port.value
      to_port         = port.value
      protocol        = "tcp"
      security_groups = [aws_security_group.alb_sg.id]
    }
  }

  # SSH only from Bastion
  ingress {
    description     = "SSH from bastion"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#  Bastion Security Group (Public SSH)
resource "aws_security_group" "bastion_sg" {
  name   = "bastion-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    description = "SSH from anywhere (as per task)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
