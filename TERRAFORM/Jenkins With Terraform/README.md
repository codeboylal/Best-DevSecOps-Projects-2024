# Terraform Docker Jenkins Container

## Overview

This Terraform script automates the deployment of a Jenkins Docker container. It utilizes the Terraform Docker provider to manage Docker resources.

## Usage

1. Ensure you have Terraform installed on your system.
2. Set up your Docker environment for Terraform to access Docker resources.
3. Run `terraform init` to initialize the working directory.
4. Run `terraform plan` to review the execution plan.
5. Run `terraform apply` to create the Docker container.
6. After use, run `terraform destroy` to remove the provisioned resources.

## Code Overview

- **Provider & Version:** Specifies the required Docker provider and version.

- **Resource:**
  - `docker_container`: Creates a Docker container using the specified Jenkins image, with internal and external ports mapped to 8080.

## Notes

- Ensure Docker is installed and running on your system.
- Adjust the container name, ports, and other configurations as needed.
- The Jenkins image will be pulled from the Docker Hub repository.

This script simplifies 
