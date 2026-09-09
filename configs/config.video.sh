#!/usr/bin/env bash

readonly URLS=(
	'https://music.youtube.com/watch?v=m-4M7u-Q45Y&si=H1DGt3q8V6rXYcIU'
)

readonly YTDLP_ARGS=(
	--download-archive .archivevideo
	--no-write-playlist-metafiles
	--output "out/video/%(playlist)s/%(title)s.%(ext)s"
)

export URLS
export YTDLP_ARGS