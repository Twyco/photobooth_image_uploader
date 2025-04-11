# Photobooth Image Uploader

## Table of contents
- [Installation](#installation)
- [Manuel Configuration](#manuel-configuration)
- [Uninstall](#uninstall)

## Installation

You can install the photobooth image uploader service with a single command using either `curl` or `wget`. Follow the steps below to get started.

### Prerequisites

Before you install the service, make sure you have the following installed:

- **Node.js** (Version 14.x or higher)
- **git**

### Install the Service

You can install the service using one of the following methods:

#### 1. Install using `curl`

Run the following command to download and install the service using `curl`:

```bash
curl -sSL https://raw.githubusercontent.com/Twyco/photobooth_image_uploader/main/install.sh | sudo bash
```

#### 1. Install using `wget`

Run the following command to download and install the service using `wget`:

```bash
wget -qO /tmp/install.sh https://raw.githubusercontent.com/Twyco/photobooth_image_uploader/main/install.sh && sudo bash /tmp/install.sh
```

#### 2. Provide the Required Data
During the installation, you will be prompted to enter certain information, such as paths and API keys. If you enter incorrect or incomplete data, or if you wish to change it later, you can do so manually as described in the [Manuel Configuration](#manuel-configuration) section.


#### 3. Verify the Installation
Check the status of the service to ensure it's running correctly:
```bash
sudo systemctl status photobooth-image-uploader.service
```

### Manuel Configuration

If you provided incorrect or missing paths during the installation, or if you want to modify them later, you can update the configuration manually as follows:

#### 1. Edit the `.env` Config File

Open the configuration file (`.env`)

```bash
sudo nano /opt/photobooth-image-uploader/.env
```

and update the following fields, like in this Example:

```
WATCH_PATH=/var/www/html/photobooth/data/images
API_URL=https://your-api-endpoint.com/api/upload-image
X_API_KEY=your-api-key-here
X_PHOTOBOOTH_AUTH_KEY=your-auth-key-here
```

#### 2. Save the Changes

When using `nano` press `Strg + O`,then `Enter` and finally `Strg + X`

### 3. Restart the Service

If the service isn't already running, you can manually start it with:

```bash
sudo systemctl restart photobooth-image-uploader.service
```

Verify the changes:
```bash
sudo systemctl status photobooth-image-uploader.service
```

## Uninstall

#### Uninstall using `curl`

Run the following command to remove the service using `curl`:

```bash
curl -sSL https://raw.githubusercontent.com/Twyco/photobooth_image_uploader/main/install.sh -o /tmp/install.sh && sudo bash /tmp/install.sh```
```
#### Uninstall using `wget`

Run the following command to remove the service using `wget`:

```bash
wget -qO- https://raw.githubusercontent.com/Twyco/photobooth_image_uploader/main/uninstall.sh | sudo bash
```