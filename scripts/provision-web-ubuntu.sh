#!/bin/bash

set -e

# Update system packages
apt-get update -y
apt-get upgrade -y

# Install Node.js (version 20.x)
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
apt-get install -y nodejs

# Install Yarn (since the app uses yarn.lock)
npm install -g yarn

# Install PM2 for process management

# Install Nginx for reverse proxy
apt-get install -y nginx

# Set app directory
APP_DIR="/vagrant/website/SuperHeros"
SERVER_APP_DIR="/vagrant/website/superhero-api"

echo "navigate to api folder"
cd "$SERVER_APP_DIR"


echo "install dependencies to api folder"
sudo yarn install
sudo yarn build
sudo yarn start


# Navigate to app directory
cd "$APP_DIR"

# Install app dependencies
sudo yarn install
# Build the Next.js app for production

sudo yarn build
sudo yarn start

# Configure Nginx reverse proxy
cat <<EOF > /etc/nginx/sites-available/superheros
server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOF

# Enable the site and restart Nginx
ln -s /etc/nginx/sites-available/superheros /etc/nginx/sites-enabled/
nginx -t
systemctl restart nginx

echo "Provisioning complete. Next.js app should be running on port 80."