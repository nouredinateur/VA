#!/bin/bash
VM_NAME=${1:-"unknown"}
echo "Cleaning up $VM_NAME server..."

# Clear package caches
sudo apt-get clean 2>/dev/null || sudo yum clean all 2>/dev/null || true

# Clear logs
sudo find /var/log -type f -name "*.log" -exec truncate -s 0 {} \; 2>/dev/null || true
sudo journalctl --vacuum-time=1d 2>/dev/null || true

# Clear service-specific logs
sudo truncate -s 0 /var/log/apache2/*.log 2>/dev/null || true
sudo truncate -s 0 /var/log/nginx/*.log 2>/dev/null || true
sudo truncate -s 0 /var/log/mysql/*.log 2>/dev/null || true
sudo truncate -s 0 /var/log/postgresql/*.log 2>/dev/null || true

# Remove temporary files
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*

# Clear bash history
history -c
cat /dev/null > ~/.bash_history

# Zero out free space
echo "Zeroing out free space for $VM_NAME..."
sudo dd if=/dev/zero of=/EMPTY bs=1M || true
sudo rm -f /EMPTY

echo "$VM_NAME cleanup complete!"