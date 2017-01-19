#!/bin/sh

# Use Uncomplicated FireWall to restrict access from the outside World

# Unless otherwise specified, ignore attempts to connect from the outside
sudo ufw --force default deny incoming

# Unless otherwise specified, allow outgoing connections
sudo ufw --force default allow outgoing

# Allow SSH
sudo ufw --force allow 'OpenSSH'

# Allow HTTP and HTTPS connections
sudo ufw --force allow 'Nginx Full'

# Enable the firewall
sudo ufw --force enable
