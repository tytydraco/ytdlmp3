#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="${SCRIPT_DIR}/lib"

function source_libraries() {
    while IFS= read -r -d '' lib_file; do
        # shellcheck disable=SC1090
        source "${lib_file}"
    done < <(find "$LIB_DIR" -type f -name "*.sh" -print0 | sort -z)
}

function main() {
    source_libraries

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
export LIB_DIR

# Execute the program.
[[ "${BASH_SOURCE[0]}" == "$0" ]] && main