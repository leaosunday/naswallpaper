# NAS Wallpaper

Docker application for automatically downloading Bing daily wallpapers to Ugreen NAS.

## Usage

### Docker Compose (Recommended)

1. Create a directory for wallpapers:
   ```bash
   mkdir -p wallpaper
   ```

2. Run with Docker Compose:
   ```bash
   docker compose up -d
   ```

### Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `CRON_SCHEDULE` | Cron expression for scheduled updates | `0 8 * * *` (daily at 8am) |
| `WALLPAPER_DIR` | Directory to save wallpapers | `/ugreen/wallpaper` |

### Build Locally

```bash
docker build -t leaosunday/naswallpaper:latest .
```

### Run Manually

```bash
docker run -d \
  -v /path/to/wallpaper:/ugreen/wallpaper \
  -e CRON_SCHEDULE="0 8 * * *" \
  -e WALLPAPER_DIR=/ugreen/wallpaper \
  --restart unless-stopped \
  leaosunday/naswallpaper:latest
```

## Features

- Downloads Bing 4K wallpaper on container startup
- Automatic scheduled updates via cron
- Retry logic (3 attempts) on download failure
- Preserves existing wallpaper on failure
- Logs to stdout for easy debugging
