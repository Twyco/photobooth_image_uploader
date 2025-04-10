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

echo "[INFO] Installing dependencies..."
npm install

echo "[INFO] Copying the systemd service file..."
cp photobooth-image-uploader.service /etc/systemd/system/photobooth-image-uploader.service

echo "[INFO] Reloading systemd and enabling the service..."
systemctl daemon-reload
systemctl enable photobooth-image-uploader.service
systemctl start photobooth-image-uploader.service

echo "[SUCCESS] Installation complete! The service is now running and will start automatically on boot."
