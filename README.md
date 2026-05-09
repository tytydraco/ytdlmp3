# ytdlmp3

YT-DLP utility for MP3 players.

# Details

This program downloads online content using `yt-dlp` and converts it for
specific Chinese MP3 players (AGPTEK, RUIZU, etc.). These players typically
support the AAC audio format, which offers the best lossy audio compared to
the other supported formats. These players also support video (AVI, AMV) under
very specific encoding conditions, so this project provides dedicated video
converters for optimal encoding. An ADTS AAC audio converter is also provided.

# Video Converters

Currently provided device-specific video converters:

- [AGPTEK M6](https://a.co/d/03IkDKGJ): [convert_agptek_m6.sh](lib/converters/convert_agptek_m6.sh)
- [RUIZU X52](https://a.co/d/085bwkvD): [convert_ruizu_x52.sh](lib/converters/convert_ruizu_x52.sh)

# Usage

1. Configure your config in [lib/config.sh](lib/config.sh).
2. Run `./main.sh`.

# Cookies

YouTube cookies are pulled from Firefox on the host machine.

# Docker

A `Dockerfile` is bundled for dependency fulfillment. The resulting files
do not need to be copied from the container to the host, as the project will
be bind-mounted to the container's working directory.

`docker.sh` can be used to build the image and start the conversion process.
The user is set to match the host, so permissions and ownership are preserved,
and Firefox cookies bind-mounted, as well, so that `yt-dlp` can access them.

- `./docker.sh build`: You only need to run at least once before `run`.
- `./docker.sh run`: Executes `main.sh` and starts the program.
- `./docker.sh clean`: Removes the container.

# Credit

- [Patched FFMPEG from fdd4s](https://github.com/fdd4s/portable_music_player_avi_video_converter_tool_2025)
- [yt-dlp](https://github.com/yt-dlp/yt-dlp)
