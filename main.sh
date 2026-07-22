#!/usr/bin/env bash
# shellcheck disable=SC1090
# shellcheck disable=SC1091

SCRIPT_DIR="$(dirname -- "$(readlink -f -- "${BASH_SOURCE[0]}")")"
MP3C_DIR="${SCRIPT_DIR}/mp3c"
CONFIG_FILE="$SCRIPT_DIR/config.sh"

function load_mp3c_converters() {
    local bk_script_dir="$SCRIPT_DIR"
    local bk_config_file="$CONFIG_FILE"
    
    source "$MP3C_DIR/main.sh"
    pull_yp3_binaries
    source_converters

    # Restore original variables.
    SCRIPT_DIR="$bk_script_dir"
    CONFIG_FILE="$bk_config_file"
}

function download_all() {
    local array_name_urls
    local array_name_ytdlp_args
    local array_name_converters
    local var_name_out_dir
    local files

    for mode in music audio video; do
        array_name_urls="URLS_${mode^^}[@]"
        array_name_ytdlp_args="YTDLP_ARGS_${mode^^}[@]"
        array_name_converters="CONVERTERS_${mode^^}[@]"

        [[ -z "${!array_name_urls}" ]] && continue

        for url in "${!array_name_urls}"; do
            yt-dlp "${!array_name_ytdlp_args}" "$url"
        done

        [[ -z "${!array_name_converters}" ]] && continue

        var_name_out_dir="OUT_DIR_${mode^^}"
        [[ ! -d "${!var_name_out_dir}" ]] && continue

        mapfile -d '' files < <(find "${!var_name_out_dir}" -type f -print0)
        [[ "${#files[@]}" -eq 0 ]] && continue

        for input_file in "${files[@]}"; do
            for converter in "${!array_name_converters}"; do
                "$converter" "$input_file"
            done

            [[ "$PRESERVE_ORIGINAL" != "true" ]] && rm "$input_file"
        done
    done
}

function main() {
    if [[ ! -f "$CONFIG_FILE" ]]; then
        echo "No config.sh file found."
        exit 1
    fi

    git submodule update --init --recursive --remote

    source "$CONFIG_FILE"
    load_mp3c_converters

    download_all
}

export SCRIPT_DIR
export MP3C_DIR
export CONFIG_FILE

[[ "${BASH_SOURCE[0]}" == "$0" ]] && main
