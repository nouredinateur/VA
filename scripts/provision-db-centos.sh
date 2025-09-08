#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "=== Updating system packages ==="
dnf update -y

# Remove any existing PostgreSQL PGDG repos to avoid GPG signature issues
echo "=== Cleaning up old PGDG repos ==="
rm -f /etc/yum.repos.d/pgdg*

# Clean DNF cache
dnf clean all

# Install PostgreSQL from CentOS Stream 9 AppStream repository
echo "=== Enabling PostgreSQL module (CentOS Stream AppStream) ==="
dnf module enable postgresql:15 -y

echo "=== Installing PostgreSQL server package ==="
dnf install -y postgresql-server

# Initialize the database
echo "=== Initializing PostgreSQL database ==="
postgresql-setup --initdb

# Start and enable PostgreSQL service
echo "=== Starting and enabling PostgreSQL service ==="
systemctl enable --now postgresql

# Optional: Configure PostgreSQL to allow remote connections
# echo "=== Configuring PostgreSQL for remote connections ==="
# sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" /var/lib/pgsql/data/postgresql.conf
# echo "host all all 0.0.0.0/0 md5" >> /var/lib/pgsql/data/pg_hba.conf
# systemctl restart postgresql

# Optional: Create a database and user
# echo "=== Creating database and user ==="
# su - postgres -c "psql -c \"CREATE USER myuser WITH PASSWORD 'mypassword';\""
# su - postgres -c "psql -c \"CREATE DATABASE mydb OWNER myuser;\""

echo "=== PostgreSQL installation completed ==="