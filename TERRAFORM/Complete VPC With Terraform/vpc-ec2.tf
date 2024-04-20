# Terraform | Provider | Version
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Creating a VPC
resource "aws_vpc" "lbb-vpc" {
  cidr_block = "10.1.0.0/16"
  tags = {
    Name = "lbb-vpc"
  }
}

# Creating Public Subnet
resource "aws_subnet" "lbb-public_subent_01" {
  vpc_id            = aws_vpc.lbb-vpc.id
  cidr_block        = "10.1.1.0/24"
  availability_zone = "us-east-2b"
  tags = {
    Name = "lbb-public_subent_01"
  }
}

# Creating Private Subnet
resource "aws_subnet" "lbb-private_subent_01" {
  vpc_id            = aws_vpc.lbb-vpc.id
  cidr_block        = "10.1.2.0/24"
  availability_zone = "us-east-2b"
  tags = {
    Name = "lbb-private_subent_01"
  }
}

# Creating Internet Gateway
resource "aws_internet_gateway" "lbb-igw" {
  vpc_id = aws_vpc.lbb-vpc.id
  tags = {
    Name = "lbb-igw"
  }
}

# Assigning Elastic_IP - * It cost budget
resource "aws_eip" "lbb-eip" {
  domain = "vpc" # Specify that the EIP should be associated with a VPC

  tags = {
    Name = "lbb-eip"
  }
}

# Creating NAT Gateway
resource "aws_nat_gateway" "lbb-ngw" {
  subnet_id     = aws_subnet.lbb-public_subent_01.id
  allocation_id = aws_eip.lbb-eip.id

  tags = {
    Name = "lbb-ngw"
  }

  # Ensure proper ordering by adding an explicit dependency on the Internet Gateway for the VPC
  depends_on = [aws_internet_gateway.lbb-igw]
}

# Creating Public Route Table
resource "aws_route_table" "lbb-public-rt" {
  vpc_id = aws_vpc.lbb-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lbb-igw.id
  }

  tags = {
    Name = "lbb-public-rt"
  }
}

# Creating Private Route Table
resource "aws_route_table" "lbb-private-rt" {
  vpc_id = aws_vpc.lbb-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.lbb-ngw.id
  }

  tags = {
    Name = "lbb-private-rt"
  }
}

# Creating Security Group
resource "aws_security_group" "lbb-ssh-sg" {
  name   = "lbb-ssh-sg"
  vpc_id = aws_vpc.lbb-vpc.id

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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lbb-ssh-sg"
  }
}

# Creating Public EC2 Instance
resource "aws_instance" "public_ec2" {
  ami                         = "ami-0f5daaa3a7fb3378b"
  instance_type               = "t2.micro"
  key_name                    = "tf-test-key"
  vpc_security_group_ids      = [aws_security_group.lbb-ssh-sg.id]
  subnet_id                   = aws_subnet.lbb-public_subent_01.id
  associate_public_ip_address = true # Ensure that the instance gets a public IP address

  tags = {
    Name = "Public-EC2"
  }
}

# Creating Private EC2 Instance
resource "aws_instance" "private_ec2" {
  ami                    = "ami-0f5daaa3a7fb3378b"
  instance_type          = "t2.micro"
  key_name               = "tf-test-key"
  vpc_security_group_ids = [aws_security_group.lbb-ssh-sg.id]
  subnet_id              = aws_subnet.lbb-private_subent_01.id

  tags = {
    Name = "Private-EC2"
  }
}

# Associating Public Subnet with Public Route Table
resource "aws_route_table_association" "lbb-rta-public-subent-1" {
  subnet_id      = aws_subnet.lbb-public_subent_01.id
  route_table_id = aws_route_table.lbb-public-rt.id
}

# Associating Private Subnet with Private Route Table
resource "aws_route_table_association" "lbb-rta-private-subent-1" {
  subnet_id      = aws_subnet.lbb-private_subent_01.id
  route_table_id = aws_route_table.lbb-private-rt.id
}