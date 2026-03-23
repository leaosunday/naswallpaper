FROM alpine:latest

RUN apk add --no-cache curl cronie

ENV CRON_SCHEDULE="0 8 * * *"
ENV WALLPAPER_DIR="/ugreen/wallpaper"

WORKDIR /app

COPY entrypoint.sh download.sh ./

RUN chmod +x ./entrypoint.sh ./download.sh

ENTRYPOINT ["./entrypoint.sh"]
