#!/bin/bash

# Update the system and install required dependencies
sudo yum update -y
sudo yum install -y docker

# Start the Docker service
sudo service docker start

# Add the ec2-user to the docker group to run Docker without sudo
sudo usermod -aG docker ec2-user

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Print Docker and Docker Compose versions
docker --version
docker-compose --version

aws s3 cp s3://ec2helpers/ ./ --recursive
