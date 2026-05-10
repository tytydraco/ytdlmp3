#!/usr/bin/env bash
# shellcheck disable=SC2016

# URLs to download (music):
URLS_MUSIC=(
    # Pop/RnB/Rap.
    "https://music.youtube.com/playlist?list=PLteo-8G34jul5Sln0GHtsQlNQib92YYdL&si=a_sW8QYkCIBQlXJf"
    
    # EDM.
    "https://music.youtube.com/playlist?list=PLteo-8G34juniGo_247mk_bXPGUf9Cnc2&si=8uh28Vs4PGm9sDu6"

    # Punk Rock.
    "https://music.youtube.com/playlist?list=PLteo-8G34jukYU7YaMhCErqpqNEq5uzX7&si=_D93cLTYUQuekxlV"

    # Weird.
    "https://music.youtube.com/playlist?list=PLteo-8G34junJ7sZNWZgMbRDZa2S-ntLP&si=fo7ISCUJM3Hmd5-W"

    # Chill pop.
    "https://music.youtube.com/playlist?list=PLteo-8G34jukzDAUMjFlo3QIMtQh4mYWs&si=39Z1ticXBaC1ccs0"

    # Chill Everything.
    "https://music.youtube.com/playlist?list=PLteo-8G34jumBUYURk_VW3Uy-EpBQ4B2Z&si=RuY_NSFqIuY6OoFJ"
)

# URLs to download (audio, past 5 items since two weeks ago):
URLS_AUDIO=(
    # Mr. Nightmare.
    "https://www.youtube.com/@mrnightmare/videos"

    # MrBallen.
    "https://www.youtube.com/@MrBallen/videos"

    # SciShow.
    "https://www.youtube.com/@SciShow/videos"

    # 2lazy2try.
    "https://www.youtube.com/@2lazy2tryYT/videos"

    # The Rest Is Science.
    "https://www.youtube.com/@TheRestIsScience/videos"

    # Critikal Chronicles.
    "https://www.youtube.com/@CritikalChronicles/videos"

    # Randy Feltface: Full Specials.
    "https://www.youtube.com/watch?v=34JfTh8sgqk&list=PLvy4k8z5JQrxw3C77tePfm0Ofk7Jp8wZN"

    # Good Griefs.
    "https://www.youtube.com/@GoodGriefs/videos"

    # American Redact.
    "https://www.youtube.com/@americanredact/videos"

    # Kill Tony.
    "https://www.youtube.com/@KillTony/videos"

    # LegalEagle.
    "https://www.youtube.com/@LegalEagle/videos"

    # tuv.
    "https://www.youtube.com/@tuv/videos"

    # CreepCast.
    "https://www.youtube.com/@CreepPodcast/videos"

    # Coffeezilla.
    "https://www.youtube.com/@Coffeezilla/videos"

    # Goblin.
    "https://www.youtube.com/@TheGBLN/videos"

    # LazyMasquerade.
    "https://www.youtube.com/@LazyMasquerade/videos"

    # Shrouded Hand.
    "https://www.youtube.com/@ShroudedHand/videos"

    # MeatCanyon.
    "https://www.youtube.com/@MeatCanyon/videos"

    # Forehead Fables Podcast.
    "https://www.youtube.com/@ForeheadFablesPodcast/videos"

    # Nexpo.
    "https://www.youtube.com/@Nexpo/videos"

    # Elvis The Alien.
    "https://www.youtube.com/@ElvistheAlien/videos"

    # Drew Gooden.
    "https://www.youtube.com/@drewisgooden/videos"

    # Law&Crime Investigates.
    "https://www.youtube.com/@LawAndCrimeInvestigates/videos"

    # Vox.
    "https://www.youtube.com/@Vox/videos"

    # ibz.
    "https://www.youtube.com/@ibz/videos"

    # poi.
    "https://www.youtube.com/@WEIRDpoi/videos"
)

# URLs to download (video):
URLS_VIDEO=(
    # Midwest Safety.
    "https://www.youtube.com/@MidwestSafety/videos"

    # penguinz0.
    "https://www.youtube.com/@penguinz0/videos"

    # Good Mythical Morning.
    "https://www.youtube.com/@GoodMythicalMorning/videos"

    # ManlyBadassHero.
    "https://www.youtube.com/@ManlyBadassHero/videos"

    # Bub Games.
    "https://www.youtube.com/@BubGames/videos"

    # Redlyne.
    "https://www.youtube.com/@Redlyne_/videos"

    # Seneral Gam.
    "https://www.youtube.com/@SeneralGam/videos"

    # Metta Beshay.
    "https://www.youtube.com/@Mettabeshay/videos"

    # Purplers.
    "https://www.youtube.com/@Purplers/videos"

    # Incognito Mode.
    "https://www.youtube.com/@IHincognitoMode/videos"
)

# Output directories:
OUT_DIR_MUSIC="out/music"
OUT_DIR_AUDIO="out/audio"
OUT_DIR_VIDEO="out/video"

# Download parameters:
BROWSER_COOKIES="firefox"

# Converters:
CONVERTERS_AUDIO=( # List of converters in lib/converters/audio.
    "convert_audio_adts_aac" # ADTS container for AAC.
)
CONVERTERS_VIDEO=( # List of converters in lib/converters/video.
    "convert_video_agptek_m6_avi" # 30FPS AVI, 320x240, rotated 90 degrees counter-clockwise.
    "convert_video_ruizu_x52_amv" # 30FPS AMV, 128x128.
)

# Download configurations for yt-dlp:
YTDLP_ARGS_MUSIC=(
    --ignore-errors
    --no-overwrites
    --downloader aria2c
    --downloader-args "aria2c:-x 16 -s 16 -k 1M"
    --download-archive .archivemusic
    --concurrent-fragments 8
    --cookies-from-browser "$BROWSER_COOKIES"
    --windows-filenames
    --no-write-playlist-metafiles
    --mtime
    --extract-audio
    --audio-format aac
    --audio-quality 0
    --format "bestaudio/best"
    --exec 'bash -c "convert_file audio \"\$1\"" _ {}'
    --output "$OUT_DIR_MUSIC/%(playlist)s/%(uploader)s - %(title)s.%(ext)s"
)
YTDLP_ARGS_AUDIO=(
    --ignore-errors
    --no-overwrites
    --downloader aria2c
    --downloader-args "aria2c:-x 16 -s 16 -k 1M"
    --datebefore now
    --dateafter now-2weeks
    --break-on-reject
    --download-archive .archiveaudio
    --concurrent-fragments 8
    --playlist-end 5
    --cookies-from-browser "$BROWSER_COOKIES"
    --windows-filenames
    --no-write-playlist-metafiles
    --mtime
    --extract-audio
    --audio-format aac
    --audio-quality 0
    --format "bestaudio/best"
    --exec 'bash -c "convert_file audio \"\$1\"" _ {}'
    --output "$OUT_DIR_AUDIO/%(playlist)s/%(title)s.%(ext)s"
)
YTDLP_ARGS_VIDEO=(
    --ignore-errors
    --no-overwrites
    --downloader aria2c
    --downloader-args "aria2c:-x 16 -s 16 -k 1M"
    --datebefore now
    --dateafter now-2weeks
    --break-on-reject
    --download-archive .archivevideo
    --concurrent-fragments 8
    --playlist-end 5
    --cookies-from-browser "$BROWSER_COOKIES"
    --windows-filenames
    --no-write-playlist-metafiles
    --mtime
    --exec 'bash -c "convert_file video \"\$1\"" _ {}'
    --output "$OUT_DIR_VIDEO/%(playlist)s/%(title)s.%(ext)s"
)

export URLS_MUSIC
export URLS_AUDIO
export URLS_VIDEO
export OUT_DIR_MUSIC
export OUT_DIR_AUDIO
export OUT_DIR_VIDEO
export BROWSER_COOKIES
export FPS
export CONVERTERS_AUDIO
export CONVERTERS_VIDEO
export YTDLP_ARGS_MUSIC
export YTDLP_ARGS_AUDIO
export YTDLP_ARGS_VIDEO