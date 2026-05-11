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

1. Configure your config in [config.sh](config.sh).
2. Run `./main.sh`.

# Cookies

YouTube cookies are pulled from Firefox on the host machine.

# Docker

A `Dockerfile` is bundled for dependency management. `docker.sh` can be used to
build the image and start the conversion process. `config.sh` will be
bind-mounted so that the image does not need to be rebuilt when the config
changes. Firefox cookies are bind-mounted, as well, so that `yt-dlp` can access them.

- `./docker.sh build`: You only needs to be run once.
- `./docker.sh run`: Executes `main.sh` and starts the program.
- `./docker.sh clean`: Removes the container.

# Project Structure

- `docker.sh` builds, runs, and erases a container for the program (local execution, containerized dependencies).
- `main.sh` sources all shell scripts under [lib/](lib/) to acquire functions and variables, including the config.
- `config.sh` provides the download content as well as universal variables for the conversions.
- `lib/convert.sh` executes a conversion, either audio or video, based on the converters variable.
- `lib/ffmpeg-mod.exe` is a vendor-patched `ffmpeg` with iframe/pframe/ipframe limits (required for AGPTEK M6).
- `lib/converters/audio/convert_audio_adts_aac.sh` converts audio into ADTS AAC.
- `lib/converters/video/convert_video_agptek_m6.sh` converts video using `lib/ffmpeg-mod.exe` (wine).
- `lib/converters/video/convert_video_ruizu_x52.sh` converts video using system `ffmpeg`.

# Credit

- [Patched FFMPEG from fdd4s](https://github.com/fdd4s/portable_music_player_avi_video_converter_tool_2025)
- [yt-dlp](https://github.com/yt-dlp/yt-dlp)
