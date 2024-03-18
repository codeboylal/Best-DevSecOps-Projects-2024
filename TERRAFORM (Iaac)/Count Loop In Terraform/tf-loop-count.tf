# Terraform | Provider | Version
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.25.0"
    }
  }
  required_version = ">= 1.2.0"
}

# Variable Instance_Count
variable "instance_count" {
  default = 2 
}

# Variable Instance_Names
variable "instance_names" {
  default = ["Public-EC2", "Private-EC2"] 
}

# Creating AWS Instances
resource "aws_instance" "my_ec2_instance" {
  count = var.instance_count

  ami           = "ami-0f5daaa3a7fb3378b"
  instance_type = "t2.micro"

  key_name = "test-key"

  security_groups = [aws_security_group.allow_ssh.name]

  tags = {
    Name = var.instance_names[count.index]
  }

  # lifecycle {
  #   prevent_destroy = true
  # }
}

# Creating Security Group
resource "aws_security_group" "allow_ssh" {
  name        = "allow-ssh"
  description = "Allow inbound SSH traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
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

# Getting Public IPs as Output
output "ec2_public_ips" {
  value = aws_instance.my_ec2_instance[*].public_ip
}
