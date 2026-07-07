#!/usr/bin/env bash
# shellcheck disable=SC1090
# shellcheck disable=SC1091

SCRIPT_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
MP3C_DIR="${SCRIPT_DIR}/mp3c"
CONFIG_FILE="$SCRIPT_DIR/config.sh"

function load_mp3c_converters() {
    local bk_script_dir="$SCRIPT_DIR"
    local bk_config_file="$CONFIG_FILE"
    
    source "$MP3C_DIR/main.sh"
    pull_yp3_binaries
    source_converters

    # Restore original variables.
    SCRIPT_DIR="$bk_script_dir"
    CONFIG_FILE="$bk_config_file"
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

# Execute the program.
[[ "${BASH_SOURCE[0]}" == "$0" ]] && main