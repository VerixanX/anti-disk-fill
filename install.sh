#!/bin/bash

# Ensure the script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root."
    exit 1
fi

echo "Setting up Anti Disk Fill..."

# Define paths
SCRIPT_URL="https://raw.githubusercontent.com/VerixanX/anti-disk-fill/main/assets/script.sh"
SCRIPT_PATH="/var/lib/pterodactyl/antidiskfillscript.sh"
SERVICE_FILE="/etc/systemd/system/cleanup.service"
TIMER_FILE="/etc/systemd/system/cleanup.timer"

# Download the external script
curl -o "$SCRIPT_PATH" "$SCRIPT_URL"

# Make the script executable
chmod +x "$SCRIPT_PATH"

# Create the systemd service file
cat << EOF > $SERVICE_FILE
[Unit]
Description=Anti Disk Fill Cleanup Script

[Service]
ExecStart=$SCRIPT_PATH
Restart=always
User=root
Environment=PATH=/usr/bin:/usr/local/bin

[Install]
WantedBy=multi-user.target
EOF

# Create the systemd timer file
cat << EOF > $TIMER_FILE
[Unit]
Description=Run Anti Disk Fill Cleanup Script Every 10 Seconds

[Timer]
OnBootSec=10s
OnUnitActiveSec=10s

[Install]
WantedBy=timers.target
EOF

# Reload systemd to recognize new service and timer
systemctl daemon-reload

# Enable and start the service and timer
systemctl enable cleanup.service
systemctl enable cleanup.timer
systemctl start cleanup.service
systemctl start cleanup.timer

echo "Anti Disk Fill has been installed and configured."
