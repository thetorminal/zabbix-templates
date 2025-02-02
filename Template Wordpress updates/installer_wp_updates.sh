#!/bin/bash

set -e  # Exit the script on any error

# Install zabbix-agent2 if not already installed
if ! dpkg -l | grep -q zabbix-agent2; then
    echo "Installing zabbix-agent2..."
    apt-get update && apt-get install -y zabbix-agent2
else
    echo "zabbix-agent2 is already installed."
fi
echo "---------------------------------"

# Install curl if not already installed
if ! dpkg -l | grep -q zabbix-agent2; then
    echo "Installing zabbix-agent2..."
    apt-get update && apt-get install -y curl
else
    echo "curl is already installed."
fi
echo "---------------------------------"

# Install WP-CLI
echo "Installing WP-CLI..."
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
php wp-cli.phar --info
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
echo "---------------------------------"

# Check if WP-CLI installation was successful
if ! command -v wp &> /dev/null; then
    echo "WP-CLI installation failed!" >&2
    exit 1
fi
echo "WP-CLI installed successfully."
echo "---------------------------------"

# Create the directory /etc/zabbix/scripts if it not exists
mkdir -p /etc/zabbix/scripts 
echo "---------------------------------"

# Download wp_discovery.sh and set permissions
echo "Downloading wp_discovery.sh..."
curl -L https://raw.githubusercontent.com/emodii/zabbix-templates/refs/heads/main/Template%20Wordpress%20updates/wp_discovery.sh -o /etc/zabbix/scripts/wp_discovery.sh
chown zabbix:zabbix /etc/zabbix/scripts/wp_discovery.sh
chmod 0755 /etc/zabbix/scripts/wp_discovery.sh
echo "---------------------------------"

# Download wp_updates.conf
echo "Downloading wp_updates.conf..."
curl -L https://raw.githubusercontent.com/emodii/zabbix-templates/refs/heads/main/Template%20Wordpress%20updates/wp_updates.conf -o /etc/zabbix/zabbix_agent2.d/wp_updates.conf
echo "---------------------------------"

# Restart zabbix-agent2
echo "Restarting zabbix-agent2..."
systemctl restart zabbix-agent2

echo "---------------------------------"
echo "Setup completed successfully!"
