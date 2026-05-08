#!/usr/bin/env bash

function convert_ruizu_x52() {
    # Assert that the input file is provided.
    if [[ -z "${1:-}" ]]; then
        echo "Usage: $0 <input_file>" >&2
        exit 1
    fi

    local input_file="$1"
    local output_file="${input_file%.*}.amv"

    # Assert that the input file is not the output file.
    if [[ "$input_file" == "$output_file" ]]; then
        echo "Input is already an AMV file, skipping: $input_file"
        exit 0
    fi

    local fps="${FPS:-30}"

    ffmpeg \
        -i "$input_file" \
        -map 0:v:0 \
        -map 0:a:0 \
        -f "amv" \
        -vf "scale=128:128:force_original_aspect_ratio=decrease,transpose=2" \
        -strict -1 \
        -c:v amv \
        -c:a adpcm_ima_amv \
        -ac 1 \
        -ar 22050 \
        -r "$fps" \
        -block_size 735 \
        "$output_file"
}

export -f convert_ruizu_x52