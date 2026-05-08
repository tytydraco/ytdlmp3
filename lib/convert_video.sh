#!/usr/bin/env bash

function convert_video() {
    # Assert that the input file is provided.
    if [[ -z "${1:-}" ]]; then
        echo "Usage: $0 <input_file>" >&2
        exit 1
    fi

    local input_file="$1"

    # Source the config since the call could be through a subshell.
    # shellcheck disable=SC1091
    source "${LIB_DIR}/config.sh"

    # Convert the video using all specified converters.
    for converter in "${CONVERTERS[@]}"; do
        "$converter" "$input_file"
    done

    # Clean up the input file if needed.
    [[ "${KEEP_ORIGINAL_VIDEO:-false}" != "true" ]] && rm -f "$input_file"
}

export -f convert_video