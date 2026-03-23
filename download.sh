#!/bin/sh

WALLPAPER_DIR="${WALLPAPER_DIR:-/ugreen/wallpaper}"

echo "Downloading wallpaper at $(date)"

retry_count=0
max_retries=3
temp_file=$(mktemp)

while [ $retry_count -lt $max_retries ]; do
    if curl -sSL -o "$temp_file" "https://bing.img.run/rand_uhd.php"; then
        if [ -s "$temp_file" ]; then
            mv "$temp_file" "$WALLPAPER_DIR/default_233.jpg"
            chmod 755 "$WALLPAPER_DIR/default_233.jpg"
            echo "Wallpaper downloaded successfully at $(date)"
            exit 0
        fi
    fi

    retry_count=$((retry_count + 1))
    echo "Download failed, retrying ($retry_count/$max_retries)..."
    sleep 2
done

rm -f "$temp_file"
echo "ERROR: Failed to download wallpaper after $max_retries attempts at $(date)"
exit 1
