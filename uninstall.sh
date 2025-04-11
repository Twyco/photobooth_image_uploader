#!/bin/bash
set -euo pipefail
trap 'echo "[ERROR] Installation failed at line $LINENO"; exit 1' ERR

INSTALL_DIR="/opt/photobooth-image-uploader"

if [[ $EUID -ne 0 ]]; then
  echo "[ERROR] This script must be run with root privileges (use sudo)."
  exit 1
fi

echo "[INFO] Deleting the repository..."
rm -rf "$INSTALL_DIR"

echo "[INFO] Disabling systemd and enabling the service..."
systemctl stop photobooth-image-uploader.service
systemctl disable photobooth-image-uploader.service
systemctl daemon-reload

echo "[INFO] Deleting the systemd service file..."
rm /etc/systemd/system/photobooth-image-uploader.service

echo "[SUCCESS] Uninstall complete!"