variable "instance_type" {
  type = string
}
variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}
variable "image_name" {
  type = string
}
variable "ports" {
      type = list(number)
 
}
variable "environment" {
  type = string
  default = "prod"
  description = "Environment tag"
}
variable "vpc_cidr" {
  type = string
}
variable "public_subnet_cidr" {
  type = string
}
variable "private_subnet_cidr" {
  type = string
}

variable "alb_ports" {
  description = "Ports for ALB"
  type        = list(number)
  default     = [80]
}

variable "ec2_ports" {
  description = "Ports for EC2 (Strapi)"
  type        = list(number)
  default     = [1337]
}
