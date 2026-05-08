#!/usr/bin/env bash

function convert_video() {
    # Assert that the input file is provided.
    if [[ -z "${1:-}" ]]; then
        echo "Usage: $0 <input_file>" >&2
        exit 1
    fi

    local input_file="$1"

    # Convert the video using all specified converters.
    for converter in "${CONVERTERS[@]}"; do
        "$converter" "$input_file"
    done

    # Clean up the input file.
    rm -f "$input_file"
}

export -f convert_video