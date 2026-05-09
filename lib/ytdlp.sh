#!/usr/bin/env bash

function ytdlp_music() {
    yt-dlp \
        -i \
        --downloader aria2c \
        --downloader-args "aria2c:-x 16 -s 16 -k 1M" \
        --download-archive "${DOWNLOAD_ARCHIVE_MUSIC:-.archivemusic}" \
        -N 8 \
        --cookies-from-browser "${DOWNLOAD_COOKIES_FROM_BROWSER:-firefox}" \
        --windows-filenames \
        --no-write-playlist-metafiles \
        --mtime \
        --extract-audio \
        --audio-format "${MUSIC_FORMAT:-aac}" \
        --audio-quality 0 \
        -f "bestaudio/best" \
        --output "$OUT_DIR_MUSIC/%(playlist)s/%(uploader)s - %(title)s.%(ext)s" \
        "$1" || true
}

function ytdlp_audio() {
    yt-dlp \
        -i \
        --downloader aria2c \
        --downloader-args "aria2c:-x 16 -s 16 -k 1M" \
        --datebefore now \
        --dateafter now-2weeks \
        --break-on-reject \
        --download-archive "${DOWNLOAD_ARCHIVE_AUDIO:-.archiveaudio}" \
        -N 8 \
        --playlist-end "${PLAYLIST_END:-5}" \
        --cookies-from-browser "${DOWNLOAD_COOKIES_FROM_BROWSER:-firefox}" \
        --windows-filenames \
        --no-write-playlist-metafiles \
        --mtime \
        --extract-audio \
        --audio-format "${AUDIO_FORMAT:-aac}" \
        --audio-quality 0 \
        -f "bestaudio/best" \
        --output "$OUT_DIR_AUDIO/%(playlist)s/%(title)s.%(ext)s" \
        "$1" || true
}

function ytdlp_video() {
    yt-dlp \
        -i \
        --downloader aria2c \
        --downloader-args "aria2c:-x 16 -s 16 -k 1M" \
        --datebefore now \
        --dateafter now-2weeks \
        --break-on-reject \
        --download-archive "${DOWNLOAD_ARCHIVE_VIDEO:-.archivevideo}" \
        -N 8 \
        --playlist-end "${PLAYLIST_END:-5}" \
        --cookies-from-browser "${DOWNLOAD_COOKIES_FROM_BROWSER:-firefox}" \
        --windows-filenames \
        --no-write-playlist-metafiles \
        --mtime \
        --exec "convert_video {}" \
        --output "$OUT_DIR_VIDEO/%(playlist)s/%(title)s.%(ext)s" \
        "$1" || true
}

export -f ytdlp_music
export -f ytdlp_audio
export -f ytdlp_video