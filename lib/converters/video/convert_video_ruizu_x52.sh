#!/usr/bin/env bash

function convert_video_ruizu_x52() {
    [[ -z "${1:-}" ]] && return 1

    local input_file="$1"
    local out_dir_video_ruizu_x52="${OUT_DIR_VIDEO}_ruizu_x52"

    local relative_path
    relative_path="$(realpath --relative-to="${OUT_DIR_VIDEO}" "$input_file")"
    local output_file="${out_dir_video_ruizu_x52}/${relative_path%.*}.amv"

    if [[ "$input_file" == "$output_file" ]]; then
        echo "[$0] Input is already converted: $input_file"
        return 0
    fi

    local fps="${FPS:-30}"

    mkdir -p "$(dirname "$output_file")"
    ffmpeg \
        -i "$input_file" \
        -n \
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
}

export -f convert_video_ruizu_x52