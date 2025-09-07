#!/bin/bash

# Update system packages
echo "Updating system packages..."
dnf update -y

# Add PostgreSQL official repository
echo "Adding PostgreSQL repository..."
dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-9-x86_64/pgdg-redhat-repo-latest.noarch.rpm

# Disable default PostgreSQL module to avoid conflicts
echo "Disabling default PostgreSQL module..."
dnf -qy module disable postgresql

# Install PostgreSQL server (using version 15 as an example, you can change to another version if needed)
echo "Installing PostgreSQL server..."
dnf install -y postgresql15-server

# Initialize the database
echo "Initializing PostgreSQL database..."
/usr/pgsql-15/bin/postgresql-15-setup initdb

# Start and enable PostgreSQL service
echo "Starting and enabling PostgreSQL service..."
systemctl enable postgresql-15
systemctl start postgresql-15

# Configure PostgreSQL to allow remote connections (optional)
# Uncomment if you need remote access
# echo "Configuring PostgreSQL for remote connections..."
# sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" /var/lib/pgsql/15/data/postgresql.conf
# echo "host all all 0.0.0.0/0 md5" >> /var/lib/pgsql/15/data/pg_hba.conf
# systemctl restart postgresql-15

# Create a database and user (optional)
# echo "Creating database and user..."
# su - postgres -c "psql -c \"CREATE USER myuser WITH PASSWORD 'mypassword';\"" 
# su - postgres -c "psql -c \"CREATE DATABASE mydb OWNER myuser;\"" 

echo "PostgreSQL installation completed!"