# Photobooth Image Uploader

## Table of contents
 - [Installation](#installation)
 - [Step 1: Install the Service](#step-1-install-the-service)
 - [Step 2: Configuration](#step-2-configuration)
 - [Step 3: Start and Enable the Service](#step-3-start-an-enable-the-service)
 - [Step 4: Verify the Installation](#step-4-verify-the-installation)

## Installation

You can install the photobooth image uploader service with a single command using either `curl` or `wget`. Follow the steps below to get started.

### Prerequisites

Before you install the service, make sure you have the following installed:

- **Node.js** (Version 14.x or higher)

### Step 1: Install the Service

You can install the service using one of the following methods:

#### Install using `curl`

Run the following command to download and install the service using `curl`:

```bash
curl -sSL https://raw.githubusercontent.com/your-username/your-repository/main/install.sh | bash
```

#### Install using `wget`

Run the following command to download and install the service using `curl`:

```bash
wget -qO- https://raw.githubusercontent.com/your-username/your-repository/main/install.sh | bash
```

### Step 2: Configuration

The uploader requires some configuration to work properly.


#### 1. Create `.env` Config File

```bash
cp /opt/photobooth-image-uploader/.env.example /opt/photobooth-image-uploader/.env
```

#### 2. Edit the `.env` Config File

Open the configuration file (`.env`)

```bash
nano /opt/photobooth-image-uploader/.env
```

and update the following fields, like in this Example:

```
WATCH_PATH=/var/www/html/photobooth/data/images
API_URL=https://your-api-endpoint.com/api/upload-image
X_API_KEY=your-api-key-here
X_PHOTOBOOTH_AUTH_KEY=your-auth-key-here
```

#### 3. Save the Changes

When using `nano` press `Strg + O`,then `Enter` and finally `Strg + X`

### Step 3. Start an Enable the Service

If the service isn't already running, you can manually start it with:
```bash
sudo systemctl start photobooth-image-uploader.service
```

To ensure that the service starts automatically on boot, enable it with:
```bash
sudo systemctl enable photobooth-image-uploader.service
```

### Step 4. Verify the Installation
Check the status of the service to ensure it's running correctly:
```bash
sudo systemctl status photobooth-image-uploader.service
```

