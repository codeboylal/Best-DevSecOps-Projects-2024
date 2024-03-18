# Complete VPC Setup with Terraform

## Overview

Automates the creation of a Virtual Private Cloud (VPC) on AWS with associated resources like subnets, internet gateway, NAT gateway, route tables, security groups, and EC2 instances.

## Usage

1. Ensure Terraform is installed.
2. Set up AWS credentials.
3. Customize variables as needed.
4. Run `terraform init` 'terraform validate', 'terraform plan' and `terraform apply`.
5. After usage, run `terraform destroy` to tear down the infrastructure.

## Code Overview

- **VPC (`aws_vpc`):** Defines the VPC with a specified CIDR block.
- **Subnets (`aws_subnet`):** Creates public and private subnets for internet-facing and internal resources.
- **Gateways and NAT (`aws_internet_gateway`, `aws_eip`, `aws_nat_gateway`):** Enables internet access for public resources and outbound internet access for private resources.
- **Route Tables (`aws_route_table`):** Manages traffic routing within the VPC.
- **Security Group (`aws_security_group`):** Controls inbound and outbound traffic for EC2 instances.
- **EC2 Instances (`aws_instance`):** Launches EC2 instances in both public and private subnets.
- **Route Table Associations (`aws_route_table_association`):** Associates subnets with route tables.

## Project Summary

This project establishes a secure VPC infrastructure on AWS. It features:

- **Public Subnet EC2 Instance:** Accessible directly via SSH from the internet.
- **Private Subnet EC2 Instance:** Accessible via SSH through the public subnet EC2 instance.

Enhancing security, the setup restricts direct access to resources in the private subnet, enforcing controlled access through the public subnet. It offers a layered approach to network security within the VPC infrastructure.

By following this guide, you can effortlessly deploy a secure and scalable cloud environment on AWS using Terraform.
