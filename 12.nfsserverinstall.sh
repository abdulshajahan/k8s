#!/bin/bash
#Run in node2 
# Minimal NFS Server Setup Script

set -e

echo "Installing nfs-utils..."
dnf install -y nfs-utils

echo "Creating NFS directory..."
mkdir -p /srv/nfs/kubedata

echo "Setting up exports..."
cat > /etc/exports << 'EOF'
/srv/nfs/kubedata *(rw,sync,no_subtree_check,no_root_squash)
EOF

echo "Starting NFS services..."
systemctl enable --now nfs-server

echo "Reloading exports..."
exportfs -rav

echo "Setup complete!"