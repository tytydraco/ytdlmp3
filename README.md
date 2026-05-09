# ytdlmp3

YT-DLP utility for MP3 players.

# Details

This program downloads online content using `yt-dlp` and converts it for
specific Chinese MP3 players (AGPTEK, RUIZU, etc.). These players typically
support the AAC audio format, which offers the best lossy audio compared to
the other supported formats. These players also support video under very
specific encoding conditions, so this project provides dedicated video
converters for optimal encoding.

Currently provided device-specific video converters:

- [AGPTEK M6](https://a.co/d/03IkDKGJ): [convert_agptek_m6.sh](lib/converters/convert_agptek_m6.sh)
- [RUIZU X52](https://a.co/d/085bwkvD): [convert_ruizu_x52.sh](lib/converters/convert_ruizu_x52.sh)

# Usage

1. Configure your conversion settings in [lib/config.sh](lib/config.sh).
2. Run `./main.sh`.

# Configuration

Under [lib/config.sh](lib/config.sh), configure these environmental variables:

- `URLS_MUSIC`: A list of URLs for audio. Optimal for music.
- `URLS_AUDIO`: A list of URLs for audio, the most recent `PLAYLIST_END` items within the past two weeks. Optimal for podcasts, audio books, or other content that will be frequently refreshed.
- `URLS_VIDEO`: A list of URLs for video, the most recent `PLAYLIST_END` items within the past two weeks. Optimal for podcasts, audio books, or other content that will be frequently refreshed.
- `OUT_DIR_MUSIC`: The music output directory.
- `OUT_DIR_AUDIO`: The audio output directory.
- `OUT_DIR_VIDEO`: The video output directory.
- `PLAYLIST_END`: The number of items to download for `URLS_AUDIO` and `URLS_VIDEO`.
- `DOWNLOAD_ARCHIVE_MUSIC`: The archive file for music.
- `DOWNLOAD_ARCHIVE_AUDIO`: The archive file for audio.
- `DOWNLOAD_ARCHIVE_VIDEO`: The archive file for videos.
- `DOWNLOAD_COOKIES_FROM_BROWSER`: The browser to pull cookies from.
- `MUSIC_FORMAT`: The audio format for music (aac, mp3, etc.).
- `AUDIO_FORMAT`: The audio format for audio (aac, mp3, etc.).
- `KEEP_ORIGINAL_VIDEO`: Whether to delete the original video file when converting videos.
- `FPS`: The frame rate for videos.
- `CONVERTERS`: A list of converters from [lib/converters](lib/converters) to use for videos. If multiple are specified, it will use both. The output directory is `${OUT_DIR_VIDEO}_<device name>`.

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
