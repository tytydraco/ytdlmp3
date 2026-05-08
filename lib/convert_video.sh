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
    local width="${WIDTH:-320}"
    local height="${HEIGHT:-240}"
    local fps="${FPS:-30}"
    local rotate="${ROTATE:-2}"
    if [[ "$rotate" -eq 1 ]]; then
        local rotate_flag="transpose=1"
    elif [[ "$rotate" -eq 2 ]]; then
        local rotate_flag="transpose=2"
    else
        local rotate_flag=""
    fi

    ffmpeg \
        -i "$input_file" \
        -map 0:v:0 \
        -map 0:a:0 \
        -f "amv" \
        -vf "scale=${width}:${height}:force_original_aspect_ratio=decrease,${rotate_flag}" \
        -strict -1 \
        -c:v amv \
        -c:a adpcm_ima_amv \
        -ac 1 \
        -ar 22050 \
        -r "$fps" \
        -block_size 735 \
        "$output_file"
}

function convert_avi() {
    # Assert that the input file is provided.
    if [[ -z "${1:-}" ]]; then
        echo "Usage: $0 <input_file>" >&2
        exit 1
    fi

    local input_file="$1"
    local output_file="${input_file%.*}.avi"

    # Assert that the input file is not already an AVI file.
    if [[ "$input_file" == "$output_file" ]]; then
        echo "Input is already an AVI file, skipping: $input_file"
        exit 0
    fi

    # Set the default values for the parameters.
    local width="${WIDTH:-320}"
    local height="${HEIGHT:-240}"
    local fps="${FPS:-30}"
    local rotate="${ROTATE:-2}"
    if [[ "$rotate" -eq 1 ]]; then
        local rotate_flag="transpose=1"
    elif [[ "$rotate" -eq 2 ]]; then
        local rotate_flag="transpose=2"
    else
        local rotate_flag=""
    fi

    wine lib/ffmpeg-mod.exe \
        -i "$input_file" \
        -map 0:v:0 \
        -map 0:a:0 \
        -profile:v baseline \
        -x264-params "imax=98304:pmax=65536:ipmax=163840" \
        -f avi \
        -vf "scale=${width}:${height}:force_original_aspect_ratio=decrease,pad=${width}:${height}:(ow-iw)/2:(oh-ih)/2:black,${rotate_flag}" \
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
}

# Export the functions so they can be used in other scripts.
export -f convert_video
export -f convert_amv
export -f convert_avi