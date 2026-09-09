#!/usr/bin/env bash
# shellcheck disable=SC1090

shopt -s nullglob

readonly CONFIGS_DIR='configs'

main() {
	[[ -d "$CONFIGS_DIR" ]] || return 0
	
	for config in "$CONFIGS_DIR"/*.sh; do
		(
			source "$config"

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
