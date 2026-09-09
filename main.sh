#!/usr/bin/env bash
# shellcheck disable=SC1090

readonly CONFIGS_DIR='configs'

main() {
	shopt -s nullglob

	[[ -d "$CONFIGS_DIR" ]] || return 0
	
	for config in "$CONFIGS_DIR"/*.sh; do
		(
			source "$config" || return 1

			(( ${#URLS[@]} )) || return 1
			(( ${#YTDLP_ARGS[@]} )) || return 1

			for url in "${URLS[@]}"; do
				yt-dlp "${YTDLP_ARGS[@]}" "$url"
			done
		)
	done
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
	main "$@"
fi
