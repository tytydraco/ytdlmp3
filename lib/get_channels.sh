#!/usr/bin/env bash

function get_channels() {
    yt-dlp \
        --cookies-from-browser firefox \
        --flat-playlist \
        --print "%(channel)s | https://www.youtube.com/channel/%(channel_id)s" \
        "https://www.youtube.com/feed/channels" | awk -F " | " '{print (NF>1)? $NF : ""}'
}