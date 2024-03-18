terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.25.0"
    }
  }
  required_version = ">= 1.2.0"
}

resource "aws_instance" "my_ec2_instance" {
  ami           = "ami-0f5daaa3a7fb3378b"
  instance_type = "t2.micro"

  key_name = "tf-test-key"

  security_groups = [aws_security_group.allow_ssh.name]

provisioner "remote-exec" {
  inline = [
    "sudo apt-get update",
    "sudo apt-get install -y nginx",
    "sudo rm -rf /var/www/html/",
    "sudo git clone https://github.com/codeboylal/docker-resume-project.git /var/www/html",
    "sudo chown -R www-data:www-data /var/www/html",
    "sudo systemctl restart nginx"
  ]
}

connection {
  type        = "ssh"
  user        = "ubuntu"
  private_key = file("/home/elon/Desktop/tf-git-web-deploy/tf-test-key.pem")
  host        = self.public_ip
  timeout     = "2m"  # Increase timeout for troubleshooting
  agent       = false  # Disable SSH agent forwarding for troubleshooting
}

lifecycle {
  prevent_destroy = true
}

tags = {
  Name = "test-server"
 }

}

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

output "ec2_public_ip" {
  value = aws_instance.my_ec2_instance.public_ip
}