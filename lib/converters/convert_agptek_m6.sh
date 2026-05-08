#!/usr/bin/env bash

function convert_agptek_m6() {
    [[ -z "${1:-}" ]] && exit 1

    local input_file="$1"
    local output_file="${input_file%.*}.avi"
    local out_dir_video_agptek_m6="${OUT_DIR_VIDEO}_agptek_m6"

    if [[ "$input_file" == "$output_file" ]]; then
        echo "[$0] Input is already converted: $input_file"
        exit 0
    fi

    local fps="${FPS:-30}"

    wine lib/ffmpeg-mod.exe \
        -i "$input_file" \
        -map 0:v:0 \
        -map 0:a:0 \
        -profile:v baseline \
        -x264-params "imax=98304:pmax=65536:ipmax=163840" \
        -f avi \
        -vf "scale=320:240:force_original_aspect_ratio=decrease,pad=320:240:(ow-iw)/2:(oh-ih)/2:black,transpose=2" \
        -strict -1 \
        -c:v libx264 \
        -c:a pcm_s16le \
        -pix_fmt yuv420p \
        -refs 1 \
        -g 7 \
        -vb 1500000 \
        -ac 1 \
        -ar 16000 \
        -r "$fps" \
        "$output_file"
    
    mkdir -p "$out_dir_video_agptek_m6"
    mv "$output_file" "$out_dir_video_agptek_m6"
}

export -f convert_agptek_m6