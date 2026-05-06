#!/usr/bin/env bash

CHANNELS="$(yt-dlp \
    --cookies-from-browser firefox \
    --flat-playlist \
    --print "%(channel)s | https://www.youtube.com/channel/%(channel_id)s" \
    "https://www.youtube.com/feed/channels" | awk -F " | " '{print (NF>1)? $NF : ""}')"

DATE=$(date +%Y-%m-%d)
for channel in $CHANNELS; do
    yt-dlp \
        -i \
        --datebefore now \
        --dateafter yesterday \
        --break-on-reject \
        --playlist-end 5 \
        --download-archive .archive \
        -N 8 \
        --cookies-from-browser firefox \
        -x \
        --audio-format mp3 \
        --embed-thumbnail \
        --embed-metadata \
        --embed-chapters \
        --output "out/${DATE}/%(uploader)s - %(title)s.%(ext)s" \
        "$channel"
done