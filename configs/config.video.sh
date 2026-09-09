#!/usr/bin/env bash

URLS=(
	# "https://youtube.com/playlist?list=..."
)

YTDLP_ARGS=(
	--download-archive .archivevideo
	--no-write-playlist-metafiles
	--output "out/video/%(playlist)s/%(title)s.%(ext)s"
)

export URLS
export YTDLP_ARGS