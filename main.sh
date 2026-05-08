#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="${SCRIPT_DIR}/lib"

# Source all the library scripts.
function source_libraries() {
    for lib in "${LIB_DIR}"/*.sh; do
        # shellcheck disable=SC1090
        source "$lib"
    done
}

# Main function.
function main() {
    # # Download the music for each URL.
    # for url in "${URLS_MUSIC[@]}"; do
    #     ytdlp_music "$url"
    # done
    
    # # Download the audio for each URL.
    # for url in "${URLS_AUDIO[@]}"; do
    #     ytdlp_audio "$url"
    # done

    # Download the video for each URL.
    for url in "${URLS_VIDEO[@]}"; do
        ytdlp_video "$url"
    done
}

# Entry point.
source_libraries
main