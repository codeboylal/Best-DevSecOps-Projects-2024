# Count Loop In Terraform

## Overview

This Terraform script automates the provisioning of AWS instances along with a security group to allow SSH traffic. It's designed to quickly set up instances with minimal configuration.

## Usage

1. Ensure you have Terraform installed on your system.
2. Set up your AWS credentials for Terraform to access your AWS account.
3. Customize the `instance_count` and `instance_names` variables if needed.
4. Run `terraform init` to initialize the working directory. 
5. Run `terraform plan` to review the execution plan.
6. Run `terraform apply` to create the AWS instances.
7. After use, run `terraform destroy` to remove the provisioned resources.

## Code Overview

- **Provider & Version:** Specifies the required Terraform provider and version.

- **Variables:**
  - `instance_count`: Specifies the number of instances to create.
  - `instance_names`: Names for the instances.

- **AWS Instances (`aws_instance`):**
  - Creates AWS instances based on the provided AMI, instance type, and key name.
  - Associates instances with the specified security group.
  - Tags instances with names provided in the `instance_names` variable.

- **Security Group (`aws_security_group`):**
  - Allows inbound SSH, HTTP, HTTPS, and custom port 8080 traffic.
  - Restricts outbound traffic to all destinations.

- **Outputs:**
  - `ec2_public_ips`: Provides public IPs of the created instances.

## Notes

- Ensure the specified AMI is available in your AWS region.
- Adjust security group rules as per your security requirements.
- Always follow AWS best practices for security and cost management.

This script facilitates the quick setup of AWS instances with necessary security configurations, suitable for various development and testing environments.
