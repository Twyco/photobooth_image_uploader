import fs from "fs";
import path from "path";
import chokidar from "chokidar";
import axios from "axios";
import dotenv from "dotenv";
import FormData = require("form-data");


dotenv.config();

const WATCH_PATH = process.env.WATCH_PATH;
const API_URL = process.env.API_URL;
const X_API_KEY = process.env.X_API_KEY;
const X_PHOTOBOOTH_AUTH_KEY = process.env.X_PHOTOBOOTH_AUTH_KEY;

if (!WATCH_PATH || !API_URL || !X_API_KEY || !X_PHOTOBOOTH_AUTH_KEY) {
  console.error("[ERROR] Invalid Config:");
  if (!WATCH_PATH) console.error(" - WATCH_PATH missing");
  if (!API_URL) console.error(" - API_URL missing");
  if (!X_API_KEY) console.error(" - X_API_KEY missing");
  if (!X_PHOTOBOOTH_AUTH_KEY) console.error(" - X_PHOTOBOOTH_AUTH_KEY missing");
  process.exit(1);
}

if (!fs.existsSync(WATCH_PATH)) {
  console.error(`[ERROR] Unknown WATCH_PATH: ${WATCH_PATH}`);
  process.exit(1);
}

try {
  fs.accessSync(WATCH_PATH, fs.constants.R_OK);
} catch (err) {
  console.error(`[ERROR] No Permissions for WATCH_PATH: ${WATCH_PATH}`);
  process.exit(1);
}

const HEADERS = {
  "x-api-key": X_API_KEY,
  "x-photobooth-auth-key": X_PHOTOBOOTH_AUTH_KEY
};

console.log(`[START] Watching ${WATCH_PATH}...`);

const watcher = chokidar.watch(WATCH_PATH, {
  persistent: true,
  ignoreInitial: true
});

watcher.on("add", async (filePath) => {
  if (!/\.(jpg|jpeg|png)$/i.test(filePath)) return;

  console.log(`[NEW] Image detected: ${filePath}`);

  try {
    const fileStream = fs.createReadStream(filePath);
    const fileName = path.basename(filePath);
    const form = new FormData();

    form.append("image", fileStream, );

    const response = await axios.post(API_URL, form, {
      headers: {
        ...HEADERS,
        ...form.getHeaders?.()
      }
    });

    if (response.status === 200) {
      console.log(`[SUCCESS] Image uploaded: ${fileName}`);
    } else {
      console.error(`[ERROR] Error while uploading: (${response.status})`);
    }
  } catch (err: any) {
    console.error(`[ERROR] Error on upload: ${err.message}`);
  }
});
