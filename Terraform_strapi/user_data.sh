#!/bin/bash
set -eux

# Log all output for debugging
exec > /var/log/user-data.log 2>&1

# Wait for network & cloud-init
sleep 60

# Update system
apt update -y

# Install Node.js 20 (required for Strapi v5)
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
apt install -y nodejs build-essential git

# Move to ubuntu home
cd /home/ubuntu

# Create Strapi app (local, not cloud)
npx create-strapi@latest strapi-app --quickstart

# Build admin panel for production
cd strapi-app
npm run build

# Start Strapi in background on boot
nohup npm start > /home/ubuntu/strapi.log 2>&1 &
