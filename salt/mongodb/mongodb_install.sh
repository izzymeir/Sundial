#!/bin/sh

# Make sure mongodb is installed

# Update authentication keys
sudo apt-key update

# Get ready to install
sudo apt-get clean
sudo apt-get update

# Install if needed
sudo apt-get install -y mongodb-org
