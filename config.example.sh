#!/usr/bin/env bash
# shellcheck disable=SC2016

# URLs to download (music):
URLS_MUSIC=(
    # "https://music.youtube.com/playlist?list=..."
)

# URLs to download (audio):
URLS_AUDIO=(
    # "https://music.youtube.com/playlist?list=..."
)

# URLs to download (video):
URLS_VIDEO=(
    # "https://music.youtube.com/playlist?list=..."
)

# Output directories:
OUT_DIR_MUSIC="out/music"
OUT_DIR_AUDIO="out/audio"
OUT_DIR_VIDEO="out/video"

# Download parameters:
BROWSER_COOKIES="firefox"
PRESERVE_ORIGINAL="false"

# Converters:
CONVERTERS_AUDIO=( # List of converters in lib/converters/audio.
    "convert_audio_adts_aac" # ADTS container for AAC.
    "convert_audio_mp3" # MP3.
)
CONVERTERS_VIDEO=( # List of converters in lib/converters/video.
    "convert_video_agptek_m6_avi" # 30FPS AVI, 320x240, rotated 90 degrees counter-clockwise.
    "convert_video_ruizu_x52_amv" # 30FPS AMV, 128x128.
    "convert_video_1080p_mkv" # Max-60FPS MKV, max-1080p.
)

# Download configurations for yt-dlp:
YTDLP_ARGS_MUSIC=(
    --ignore-errors
    --no-overwrites
    --downloader aria2c
    --downloader-args "aria2c:-x 16 -s 16 -k 1M"
    --download-archive .archivemusic
    --concurrent-fragments 8
    --cookies-from-browser "$BROWSER_COOKIES"
    --windows-filenames
    --no-write-playlist-metafiles
    --mtime
    --extract-audio
    --audio-format aac
    --audio-quality 0
    --format "bestaudio/best"
    --exec 'bash -c "convert_file audio \"\$1\"" _ {}'
    --output "$OUT_DIR_MUSIC/%(playlist)s/%(uploader)s - %(title)s.%(ext)s"
)
YTDLP_ARGS_AUDIO=(
    --ignore-errors
    --no-overwrites
    --downloader aria2c
    --downloader-args "aria2c:-x 16 -s 16 -k 1M"
    --download-archive .archiveaudio
    --concurrent-fragments 8
    --cookies-from-browser "$BROWSER_COOKIES"
    --windows-filenames
    --no-write-playlist-metafiles
    --mtime
    --extract-audio
    --audio-format aac
    --audio-quality 0
    --format "bestaudio/best"
    --exec 'bash -c "convert_file audio \"\$1\"" _ {}'
    --output "$OUT_DIR_AUDIO/%(playlist)s/%(title)s.%(ext)s"
)
YTDLP_ARGS_VIDEO=(
    --ignore-errors
    --no-overwrites
    --downloader aria2c
    --downloader-args "aria2c:-x 16 -s 16 -k 1M"
    --download-archive .archivevideo
    --concurrent-fragments 8
    --cookies-from-browser "$BROWSER_COOKIES"
    --windows-filenames
    --no-write-playlist-metafiles
    --mtime
    --exec 'bash -c "convert_file video \"\$1\"" _ {}'
    --output "$OUT_DIR_VIDEO/%(playlist)s/%(title)s.%(ext)s"
)

export URLS_MUSIC
export URLS_AUDIO
export URLS_VIDEO
export OUT_DIR_MUSIC
export OUT_DIR_AUDIO
export OUT_DIR_VIDEO
export BROWSER_COOKIES
export PRESERVE_ORIGINAL
export FPS
export CONVERTERS_AUDIO
export CONVERTERS_VIDEO
export YTDLP_ARGS_MUSIC
export YTDLP_ARGS_AUDIO
export YTDLP_ARGS_VIDEO