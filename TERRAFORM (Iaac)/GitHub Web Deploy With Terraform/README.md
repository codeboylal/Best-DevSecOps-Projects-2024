# GitHub to EC2 with Nginx Provisioning

## Overview

This Terraform script automates the deployment of an AWS EC2 instance with Nginx installed and configured. It also sets up a security group to allow SSH, HTTP, and HTTPS traffic.

## Usage

1. Ensure you have Terraform installed on your system.
2. Set up your AWS credentials for Terraform to access your AWS account.
3. Run `terraform init` to initialize the working directory.
4. Run `terraform plan` to review the execution plan.
5. Run `terraform apply` to create the AWS EC2 instance and associated resources.
6. After use, run `terraform destroy` to remove the provisioned resources.

## Code Overview

- **Provider & Version:** Specifies the required AWS provider and version.

- **Resource:**
  - `aws_instance`: Defines an EC2 instance with Nginx provisioning using remote-exec provisioner.
  - `aws_security_group`: Configures a security group to allow SSH, HTTP, and HTTPS traffic.

## Notes

- Adjust the AMI, instance type, key name, and other configurations as needed.
- Ensure to provide the correct path to your private key file.
- This script sets up a basic Nginx server serving content from a GitHub repository.

This script simplifies the deployment of an AWS EC2 instance with Nginx provisioning using Terraform, suitable for web server setups and demonstrations.
