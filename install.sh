#!/bin/bash

sudo su

INSTALL_DIR="/opt/photobooth-image-uploader"
GIT_REPO_URL="https://github.com/Twyco/photobooth_image_uploader.git"

if ! command -v node &>/dev/null; then
    echo "Node.js is not installed. Please install."
    exit 1
fi

echo "Cloning the repository..."
git clone "$GIT_REPO_URL" "$INSTALL_DIR"

cd "$INSTALL_DIR" || exit

echo "Installing dependencies..."
npm install

echo "Copying the systemd service file..."
cp "$INSTALL_DIR/photobooth-image-uploader.service" /etc/systemd/system/photobooth-image-uploader.service

echo "Reloading systemd and enabling the service..."
systemctl daemon-reload
systemctl enable photobooth-image-uploader.service
systemctl start photobooth-image-uploader.service

echo "Installation complete! The service is now running and will start automatically on boot."

echo "Service-Logs:"
journalctl -u photobooth-image-uploader.service -n 10
