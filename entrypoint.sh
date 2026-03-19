#!/bin/sh

set -e

echo "Starting naswallpaper..."
echo "WALLPAPER_DIR: $WALLPAPER_DIR"
echo "CRON_SCHEDULE: $CRON_SCHEDULE"

# Ensure wallpaper directory exists
mkdir -p "$WALLPAPER_DIR"

# Function to download wallpaper with retry
download_wallpaper() {
    echo "Downloading wallpaper at $(date)"
    local retry_count=0
    local max_retries=3
    local temp_file=$(mktemp)

    while [ $retry_count -lt $max_retries ]; do
        if curl -sSL -o "$temp_file" "https://bing.img.run/rand_uhd.php"; then
            if [ -s "$temp_file" ]; then
                mv "$temp_file" "$WALLPAPER_DIR/default_233.jpg"
                echo "Wallpaper downloaded successfully at $(date)"
                return 0
            fi
        fi

        retry_count=$((retry_count + 1))
        echo "Download failed, retrying ($retry_count/$max_retries)..."
        sleep 2
    done

    rm -f "$temp_file"
    echo "ERROR: Failed to download wallpaper after $max_retries attempts at $(date)"
    return 1
}

# Download wallpaper immediately on startup
echo "Downloading initial wallpaper..."
download_wallpaper || echo "Initial download failed, will retry on next cron run"

# Setup cron
echo "$CRON_SCHEDULE cd /app && /entrypoint.sh download_only" > /etc/crontabs/root

# Start cron in foreground
echo "Starting cron scheduler..."
crond -f -L /dev/stdout
