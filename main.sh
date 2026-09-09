#!/usr/bin/env bash
# shellcheck disable=SC1090

shopt -s nullglob

readonly CONFIGS_DIR='configs'

main() {
	if [[ ! -f "$CONFIG_FILE" ]]; then
		echo 'No config.sh file found.'
		return 1
	fi

	[[ -d "$CONFIGS_DIR" ]] || return 1
	
	for config in "$CONFIGS_DIR"/*.sh; do
		(
			source "$config" || return 1
			[[ -n "$URLS" ]] || return 1
			[[ -n "$YTDLP_ARGS" ]] || return 1

			for url in "${URLS[@]}"; do
				yt-dlp "${YTDLP_ARGS[@]}" "$url"
			done
		)
	done
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
	main "$@"
fi
