#!/usr/bin/env bash

function convert_ruizu_x52() {
    [[ -z "${1:-}" ]] && exit 1

    local input_file="$1"
    local output_file="${input_file%.*}.amv"
    local out_dir_video_ruizu_x52="${OUT_DIR_VIDEO}_ruizu_x52"

    if [[ "$input_file" == "$output_file" ]]; then
        echo "[$0] Input is already converted: $input_file"
        exit 0
    fi

    local fps="${FPS:-30}"

    ffmpeg \
        -i "$input_file" \
        -map 0:v:0 \
        -map 0:a:0 \
        -f "amv" \
        -vf "scale=128:128:force_original_aspect_ratio=decrease" \
        -strict -1 \
        -c:v amv \
        -c:a adpcm_ima_amv \
        -ac 1 \
        -ar 22050 \
        -r "$fps" \
        -block_size 735 \
        "$output_file"

    mkdir -p "$out_dir_video_ruizu_x52"
    mv "$output_file" "$out_dir_video_ruizu_x52"
}

export -f convert_ruizu_x52