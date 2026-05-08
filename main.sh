#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="${SCRIPT_DIR}/lib"

# Source all the library scripts.
function source_libraries() {
    while IFS= read -r -d '' lib_file; do
        # shellcheck disable=SC1090
        source "${lib_file}"
    done < <(find "${LIB_DIR}" -type f -name "*.sh" -print0 | sort -z)
}

# Main function.
function main() {
    # Download the music for each URL.
    for url in "${URLS_MUSIC[@]}"; do
        ytdlp_music "$url"
    done
    
    # Download the audio for each URL.
    for url in "${URLS_AUDIO[@]}"; do
        ytdlp_audio "$url"
    done

    # Download the video for each URL.
    for url in "${URLS_VIDEO[@]}"; do
        ytdlp_video "$url"
    done
}

export SCRIPT_DIR
export LIB_DIR

# Entry point.
source_libraries
main