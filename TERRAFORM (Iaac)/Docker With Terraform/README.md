# Terraform Docker Nginx Container

## Overview

This Terraform script automates the deployment of an Nginx Docker container. It utilizes the Terraform Docker provider to manage Docker resources.

## Usage

1. Ensure you have Terraform installed on your system.
2. Set up your Docker environment for Terraform to access Docker resources.
3. Run `terraform init` to initialize the working directory.
4. Run `terraform plan` to review the execution plan.
5. Run `terraform apply` to create the Docker container.
6. After use, run `terraform destroy` to remove the provisioned resources.

## Code Overview

- **Provider & Version:** Specifies the required Docker provider and version.

- **Resources:**
  - `docker_image`: Defines the Nginx Docker image to be used.
  - `docker_container`: Creates a Docker container using the Nginx image, with specified internal and external ports.

## Notes

- Ensure Docker is installed and running on your system.
- Adjust the container name, ports, and other configurations as needed.
- The specified Nginx image will be pulled from the Docker Hub repository.
- Make sure the specified Docker image exists and is accessible.

This script simplifies the deployment of an Nginx Docker container using Terraform, suitable for various development and testing scenarios.
