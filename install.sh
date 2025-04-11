#!/bin/bash
set -euo pipefail
trap 'echo "[ERROR] Installation failed at line $LINENO"; exit 1' ERR

INSTALL_DIR="/opt/photobooth-image-uploader"
GIT_REPO_URL="https://github.com/Twyco/photobooth_image_uploader"

if [[ $EUID -ne 0 ]]; then
  echo "[ERROR] This script must be run with root privileges (use sudo)."
  exit 1
fi

if ! command -v node &>/dev/null; then
    echo "[ERROR] Node.js is not installed. Please install Node.js first."
    exit 1
fi

echo "[INFO] Cloning the repository..."
git clone "$GIT_REPO_URL" "$INSTALL_DIR"

cd "$INSTALL_DIR"

echo "[INFO] creating config File..."
cp .env.example .env

# Declare variables to prevent set -u from failing
WATCH_PATH="X"
API_URL="X"
X_API_KEY="X"
X_PHOTOBOOTH_AUTH_KEY="X"

# Prompt user
read -rp 'Enter WATCH_PATH (e.g. /var/www/html/...): ' WATCH_PATH
read -rp 'Enter API_URL (e.g. https://photobooth.test/api/upload-image): ' API_URL
read -rp 'Enter X_API_KEY: ' X_API_KEY
read -rp 'Enter X_PHOTOBOOTH_AUTH_KEY: ' X_PHOTOBOOTH_AUTH_KEY

echo "WATCH_PATH=$WATCH_PATH"
echo "API_URL=$API_URL"
echo "X_API_KEY=$X_API_KEY"
echo "X_PHOTOBOOTH_AUTH_KEY=$X_PHOTOBOOTH_AUTH_KEY"

echo "[INFO] Installing dependencies..."
npm install

echo "[INFO] Building Service..."
npm run build

echo "[INFO] Copying the systemd service file..."
cp photobooth-image-uploader.service /etc/systemd/system/photobooth-image-uploader.service

echo "[INFO] Reloading systemd and enabling the service..."
systemctl daemon-reload
systemctl enable photobooth-image-uploader.service
systemctl start photobooth-image-uploader.service

echo "[SUCCESS] Installation complete! The service is now running and will start automatically on boot."
