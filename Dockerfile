FROM alpine:latest

RUN apk add --no-cache curl crontab

ENV CRON_SCHEDULE="0 8 * * *"
ENV WALLPAPER_DIR="/ugreen/wallpaper"

WORKDIR /app

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
