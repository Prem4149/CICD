#!/bin/bash

# Exit on error
set -e

echo "Starting system setup..."

# Task 1: Update System Packages
echo "Updating system packages..."
sudo yum update -y

# Task 2: Install Essential Packages
echo "Installing essential packages (wget, curl, git, vim, net-tools)..."
sudo yum install -y wget curl git vim net-tools

# Task 3: Create a New User
NEW_USER="devops"
echo "Creating user: $NEW_USER"
sudo useradd -m -s /bin/bash $NEW_USER
sudo passwd $NEW_USER
sudo usermod -aG wheel $NEW_USER

# Task 4: Configure Firewall
echo "Configuring firewall to allow SSH and HTTP traffic..."
sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --reload

# Task 5: Set Hostname
NEW_HOSTNAME="centos-dev"
echo "Setting hostname to $NEW_HOSTNAME..."
sudo hostnamectl set-hostname $NEW_HOSTNAME

# Task 6: Enable and Start Nginx
echo "Installing and starting Nginx..."
sudo yum install -y epel-release
sudo yum install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx

# Task 7: Create a Sample Web Page
echo "Creating a sample web page..."
echo "<h1>Welcome to CentOS</h1>" | sudo tee /usr/share/nginx/html/index.html

# Task 8: Install and Start Docker
echo "Installing Docker..."
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce docker-ce-cli containerd.io
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $NEW_USER

# Task 9: Schedule a Cron Job
echo "Setting up a cron job to clear logs every day..."
(crontab -l 2>/dev/null; echo "0 0 * * * sudo find /var/log -type f -name '*.log' -delete") | crontab -

# Task 10: Check System Status
echo "System status summary:"
uptime
df -h
free -m

echo "All tasks completed successfully!"
