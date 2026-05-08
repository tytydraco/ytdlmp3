#!/usr/bin/env bash

function convert_video() {
    # Assert that the input file is provided.
    if [[ -z "${1:-}" ]]; then
        echo "Usage: $0 <input_file>" >&2
        exit 1
    fi

    local input_file="$1"
    local format="${FORMAT:-avi}"

    case "$format" in
        avi)
            convert_avi "$input_file"
            ;;
        amv)
            convert_amv "$input_file"
            ;;
        *)
            echo "Unsupported FORMAT: ${format}"
            echo "Expected FORMAT to be avi or amv."
            exit 1
            ;;
    esac

    rm -f "$input_file"
}

export -f convert_video