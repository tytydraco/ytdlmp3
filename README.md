# ytdlmp3

YT-DLP utility for MP3 players.

# Usage

1. Configure your conversion settings in [lib/config.sh](lib/config.sh).
2. Run `./main.sh`.

# Presets

These are optimized presets for the following devices:

- AGPTEK M6 (AVI, 320x240, rotated 90 degrees counter-clockwise):
  - WIDTH=320
  - HEIGHT=240
  - FPS=30
  - ROTATE=2
  - FORMAT="avi"
- RUIZU X52 (AMV, 128x128):
  - WIDTH=128
  - HEIGHT=128
  - FPS=30
  - ROTATE=0
  - FORMAT="amv"

# Credit

- Patched FFMPEG from fdd4s: https://github.com/fdd4s/portable_music_player_avi_video_converter_tool_2025
