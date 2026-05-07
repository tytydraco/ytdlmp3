#!/usr/bin/env bash

function convert_amv() {
    # Assert that the input file is provided.
    if [[ -z "${1:-}" ]]; then
        echo "Usage: $0 <input_file>" >&2
        exit 1
    fi

    local input_file="$1"
    local output_file="${input_file%.*}.amv"

    # Assert that the input file is not already an AMV file.
    if [[ "$input_file" == "$output_file" ]]; then
        echo "Input is already an AMV file, skipping: $input_file"
        exit 0
    fi

    # Set the default values for the parameters.
    local width="${WIDTH:-240}"
    local height="${HEIGHT:-320}"
    local fps="${FPS:-30}"

    ffmpeg \
        -i "$input_file" \
        -map 0:v:0 \
        -map 0:a:0 \
        -f "amv" \
        -vf "scale=${width}:${height}, crop=${width}:${height}" \
        -strict -1 \
        -c:v amv \
        -c:a adpcm_ima_amv \
        -ac 1 \
        -ar 22050 \
        -r "$fps" \
        -block_size 735 \
        "$output_file"

    rm -f -- "$input_file"
}

# Export the function so it can be used in other scripts.
export -f convert_amv