#!/usr/bin/env bash

URLS=(
	# "https://music.youtube.com/playlist?list=..."
)

YTDLP_ARGS=(
	--download-archive .archivemusic
	--no-write-playlist-metafiles
	--extract-audio
	--audio-format mp3
	--audio-quality 0
	--format 'bestaudio/best'
	--output 'out/music/%(playlist)s/%(uploader)s - %(title)s.%(ext)s'
)

export URLS
export YTDLP_ARGS