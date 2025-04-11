#!/bin/bash
set -euo pipefail
trap 'echo "[ERROR] Installation failed at line $LINENO"; exit 1' ERR

INSTALL_DIR="/opt/photobooth-image-uploader"
GIT_REPO_URL="https://github.com/Twyco/photobooth_image_uploader"

if ! command -v node &>/dev/null; then
    echo "[ERROR] Node.js is not installed. Please install Node.js first."
    exit 1
fi

echo "[INFO] Please provide the following configuration values:"
read -rp 'WATCH_PATH (e.g. /var/www/html/photobooth/data/images): ' WATCH_PATH
read -rp 'API_URL (e.g. https://photobooth.test/api/upload-image): ' API_URL
read -rp 'X_API_KEY: ' X_API_KEY
read -rp 'X_PHOTOBOOTH_AUTH_KEY: ' X_PHOTOBOOTH_AUTH_KEY

echo "[INFO] Cloning the repository..."
sudo git clone "$GIT_REPO_URL" "$INSTALL_DIR"

sudo cd "$INSTALL_DIR"

echo "[INFO] Creating .env file..."
sudo cat <<EOF >.env
WATCH_PATH=$WATCH_PATH
API_URL=$API_URL
X_API_KEY=$X_API_KEY
X_PHOTOBOOTH_AUTH_KEY=$X_PHOTOBOOTH_AUTH_KEY
EOF

echo "[INFO] Installing dependencies..."
sudo npm install

echo "[INFO] Building Service..."
sudo npm run build

echo "[INFO] Copying the systemd service file..."
sudo cp photobooth-image-uploader.service /etc/systemd/system/photobooth-image-uploader.service

echo "[INFO] Reloading systemd and enabling the service..."
sudo systemctl daemon-reload
sudo systemctl enable photobooth-image-uploader.service
sudo systemctl start photobooth-image-uploader.service

echo "[SUCCESS] Installation complete! The service is now running and will start automatically on boot."
