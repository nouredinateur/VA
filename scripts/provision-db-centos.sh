#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "=== Updating system packages ==="
dnf update -y

# Clean DNF cache
dnf clean all

# Install MySQL from CentOS Stream 9 AppStream repository
echo "=== Installing MySQL server package ==="
dnf install -y mysql-server

# Start and enable MySQL service
echo "=== Starting and enabling MySQL service ==="
systemctl enable --now mysqld

# Secure MySQL installation (optional - uncomment if needed)
# echo "=== Securing MySQL installation ==="
# mysql_secure_installation

# Optional: Configure MySQL to allow remote connections
# echo "=== Configuring MySQL for remote connections ==="
# sed -i 's/bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/' /etc/my.cnf.d/mysql-server.cnf
# systemctl restart mysqld

# Optional: Create a database and user
# echo "=== Creating database and user ==="
# mysql -e "CREATE USER 'myuser'@'%' IDENTIFIED BY 'mypassword';"
# mysql -e "CREATE DATABASE mydb;"
# mysql -e "GRANT ALL PRIVILEGES ON mydb.* TO 'myuser'@'%';"
# mysql -e "FLUSH PRIVILEGES;"

echo "=== MySQL installation completed ==="