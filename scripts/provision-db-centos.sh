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
# Autoriser l’écoute sur toutes les interfaces
echo "=== Autoriser les connexions distantes ==="
sed -i 's/^bind-address\s*=.*/bind-address = 0.0.0.0/' /etc/my.cnf.d/mysql-server.cnf
systemctl restart mysqld

# Ouvrir le port 3306 dans firewalld
firewall-cmd --add-service=mysql --permanent
firewall-cmd --reload

# Créer la base / l’utilisateur
echo "=== Création de la base et de l’utilisateur ==="
mysql -e "CREATE USER IF NOT EXISTS 'myuser'@'%' IDENTIFIED BY 'mypassword';"
mysql -e "CREATE DATABASE IF NOT EXISTS superhero_db;"
mysql -e "GRANT ALL PRIVILEGES ON superhero_db.* TO 'myuser'@'%';"
mysql -e "FLUSH PRIVILEGES;"

# Importer les données de démonstration
echo "=== Import des données ==="
mysql -umyuser -pmypassword superhero_db < /home/vagrant/database/create-table.sql
mysql -umyuser -pmypassword superhero_db < /home/vagrant/database/insert-demo-data.sql

echo "=== Installation MySQL terminée ==="