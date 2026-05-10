#!/usr/bin/env bash

function convert_audio_adts_aac() {
    [[ -z "${1:-}" ]] && return 1

    local input_file="$1"
    local out_dir
    local output_file

    out_dir="$(dirname "$input_file")/aac_adst"
    output_file="${out_dir}/$(basename "${input_file%.*}").aac"

    if [[ "$input_file" == "$output_file" ]]; then
        echo "[$0] Input is already converted: $input_file"
        return 0
    fi

    mkdir -p "$out_dir"
    ffmpeg \
        -i "$input_file" \
        -n \
        -c:a aac \
        -f adts \
        "$output_file"
}

export -f convert_audio_adts_aac