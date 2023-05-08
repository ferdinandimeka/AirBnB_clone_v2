#!/usr/bin/env bash

# Install Nginx if it's not already installed
if ! command -v nginx > /dev/null; then
    sudo apt-get update
    sudo apt-get -y install nginx
fi

# Create necessary directories
sudo mkdir -p /data/web_static/releases/test /data/web_static/shared /data/web_static/current

# Create a fake HTML file for testing
echo "Test page" | sudo tee /data/web_static/releases/test/index.html

# Create a symbolic link
sudo ln -sf /data/web_static/releases/test/ /data/web_static/current

# Give ownership of /data/ folder to the ubuntu user and group
sudo chown -R ubuntu:ubuntu /data/

# Update Nginx configuration
CONFIG_FILE=/etc/nginx/sites-available/default
sudo sed -i "/^\s*location \/ {$/,/^\s*}$/s/^/\t/" $CONFIG_FILE
sudo sed -i "/^\s*location \/ {$/,/^\s*}$/a \\\talias /data/web_static/current/;" $CONFIG_FILE

# Restart Nginx
sudo service nginx restart

exit 0
