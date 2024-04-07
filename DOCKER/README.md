# SonarQube Docker Compose Setup

This repository contains a Docker Compose file for setting up SonarQube with Docker.

## Prerequisites

- Docker Engine
    ```bash
    sudo apt install docker.io -y
    ```
- Docker Compose
    ```bash
    sudo apt install docker-compose-y
    ```
## Installation

1. Clone this repository to your local machine:

    ```bash
    git clone https://github.com/codeboylal/DevSecOps-Projects.git
    ```

2. Navigate to the cloned directory:

    ```bash
    cd DOCKER
    ```

## Usage

To start SonarQube, run:

```bash
docker-compose up -d
```
```bash
docker ps
```
To access SonarQube, visit [http://127.0.0.1:9000](http://127.0.0.1:9000)

## Default Credentials
- username: admin
- password: admin



