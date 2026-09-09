#!/usr/bin/env bash

URLS=(
	'https://music.youtube.com/watch?v=m-4M7u-Q45Y&si=H1DGt3q8V6rXYcIU'
)

YTDLP_ARGS=(
	--download-archive .archiveaudio
	--cookies-from-browser firefox
	--no-write-playlist-metafiles
	--extract-audio
	--audio-format mp3
	--audio-quality 0
	--format 'bestaudio/best'
	--output 'out/audio/%(playlist)s/%(title)s.%(ext)s'
)

export URLS
export YTDLP_ARGS