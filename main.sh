#!/usr/bin/env bash
# shellcheck disable=SC1090
# shellcheck disable=SC1091

SCRIPT_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
MP3C_DIR="${SCRIPT_DIR}/mp3c"
CONFIG_FILE="$SCRIPT_DIR/config.sh"

FFMPEG_YP3="$MP3C_DIR/tools/ffmpeg/ffmpeg-yp3-patch/static/ffmpeg"
ATJ_AVI_ENCODER="$MP3C_DIR/tools/ffmpeg/atj-avi-encoder/make-atj-avi-encoder.sh"

function load_mp3c_converters() {
    while IFS= read -r -d '' src; do
        source "$src"
    done < <(find "$MP3C_DIR/converters" -type f -name "*.sh" -print0 | sort -z)
}

function main() {
    if [[ ! -f "$CONFIG_FILE" ]]; then
        echo "No config.sh file found."
        exit 1
    fi

    # Pull latest submodules.
    git submodule update --init --recursive --remote

    source "$CONFIG_FILE"
    load_mp3c_converters

    # Download the music for each URL.
    for url in "${URLS_MUSIC[@]}"; do
        yt-dlp "${YTDLP_ARGS_MUSIC[@]}" "$url"
    done
    
    # Download the audio for each URL.
    for url in "${URLS_AUDIO[@]}"; do
        yt-dlp "${YTDLP_ARGS_AUDIO[@]}" "$url"
    done

    # Download the videos for each URL.
    for url in "${URLS_VIDEO[@]}"; do
        yt-dlp "${YTDLP_ARGS_VIDEO[@]}" "$url"
    done
}

export SCRIPT_DIR
export MP3C_DIR
export CONFIG_FILE
export FFMPEG_YP3
export ATJ_AVI_ENCODER

# Execute the program.
[[ "${BASH_SOURCE[0]}" == "$0" ]] && main