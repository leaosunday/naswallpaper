# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**naswallpaper** - Docker application for automatically downloading Bing daily wallpapers to Ugreen NAS.

The app downloads 4K wallpapers from `https://bing.img.run/rand_uhd.php` on container startup and at scheduled times defined by a cron expression.

## Build & Run

### Build Image

```bash
docker build -t leaosunday/naswallpaper:latest .
```

### Run with Docker Compose

```bash
docker compose up -d
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

### View Logs

```bash
docker logs -f naswallpaper
```

## Architecture

- **Base:** Alpine Linux (minimal image)
- **Tools:** curl (download), crond (scheduling)
- **Entry:** entrypoint.sh - handles startup download and cron setup

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `CRON_SCHEDULE` | Cron expression for scheduled updates | `0 8 * * *` |
| `WALLPAPER_DIR` | Directory to save wallpapers | `/ugreen/wallpaper` |

## Key Behaviors

- Downloads wallpaper immediately on container startup
- Retries 3 times on failure, preserves existing wallpaper
- All logs go to stdout
