#!/bin/bash
set -eux

exec > /var/log/user-data.log 2>&1

sleep 60

apt update -y

# Install dependencies
apt install -y curl git build-essential python3

# Install Node
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
apt install -y nodejs

cd /home/ubuntu

npx create-strapi@latest my-strapi --quickstart 


cd /home/ubuntu/my-strapi
npm run build

nohup npm start > /home/ubuntu/strapi.log 2>&1 &
