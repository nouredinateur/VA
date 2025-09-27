## 🚀 Quick Start

### Prerequisites

- VMware Desktop (or VirtualBox)
- Vagrant installed
- 4GB+ RAM available

### 1. Start the VMs

```bash
# Start both web and database servers
vagrant up

# Check status
vagrant status
```

### 2. Access the Application

- **Website**: http://192.168.56.10
- **API**: http://192.168.56.10/api

### 3. Access Database

```bash
# From your computer
mysql -h localhost -P 3307 -u myuser -p
# Password: mypassword

# View data
USE superhero_db;
SELECT * FROM superheroes;
```

## 🔧 VM Management

```bash
# Start specific VM
vagrant up web    # Web server only
vagrant up db     # Database only

# Connect to VMs
vagrant ssh web   # SSH to web server
vagrant ssh db    # SSH to database

# Stop VMs
vagrant halt      # Stop all
vagrant halt web  # Stop web only

# Restart VMs
vagrant reload

# Destroy and recreate
vagrant destroy
vagrant up
```

## 🛠️ Troubleshooting

### Check Services

```bash
# Web server
vagrant ssh web
pm2 status
sudo systemctl status nginx

# Database
vagrant ssh db
sudo systemctl status mysqld
```

### Test Connectivity

```bash
# Test web access
curl http://192.168.56.10

# Test API
curl http://192.168.56.10/api/superheroes
```

### Common Issues

- **VMs won't start**: Run `vagrant destroy` then `vagrant up`
- **Services not running**: Run `vagrant provision`
- **Can't access website**: Check if IP 192.168.56.10 is accessible
- **Database connection fails**: Verify port 3307 is forwarded

## 📦 What Gets Installed

**Web Server (Ubuntu)**:

- Node.js & Yarn
- Next.js frontend application
- Node.js API backend
- Nginx reverse proxy
- PM2 process manager

**Database Server (CentOS)**:

- MySQL 8.0
- SuperHero database with sample data
- Firewall configured for MySQL access

## 🌐 Network Setup

- Web Server: 192.168.56.10 (public + private network)
- Database: 192.168.56.11 (private network only)
- Database Port Forward: localhost:3307 → VM:3306

That's it! Run `vagrant up` and access http://192.168.56.10 to see your superhero application.
