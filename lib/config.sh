#!/usr/bin/env bash

# URLs to download as MP3 (music).
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

# URLs to download as MP3 (past 5 items since two weeks ago).
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

    # Horses.
    "https://www.youtube.com/@HorsesOnYT/videos"

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
)

# URLs to download as AMV.
URLS_VIDEO=(
    # Midwest Safety.
    "https://www.youtube.com/@MidwestSafety/videos"

    # Vox.
    "https://www.youtube.com/@Vox/videos"

    # penguinz0.
    "https://www.youtube.com/@penguinz0/videos"

    # Good Mythical Morning.
    "https://www.youtube.com/@GoodMythicalMorning/videos"

    # ManlyBadassHero.
    "https://www.youtube.com/@ManlyBadassHero/videos"

    # Bub Games.
    "https://www.youtube.com/@BubGames/videos"

    # Law&Crime Investigates.
    "https://www.youtube.com/@LawAndCrimeInvestigates/videos"

    # ibz.
    "https://www.youtube.com/@ibz/videos"

    # poi.
    "https://www.youtube.com/@WEIRDpoi/videos"

    # Redlyne.
    "https://www.youtube.com/@Redlyne_/videos"

    # Seneral Gam.
    "https://www.youtube.com/@SeneralGam/videos"

    # Drew Gooden.
    "https://www.youtube.com/@drewisgooden/videos"

    # Metta Beshay.
    "https://www.youtube.com/@Mettabeshay/videos"

    # Purplers.
    "https://www.youtube.com/@Purplers/videos"

    # Incognito Mode.
    "https://www.youtube.com/@IHincognitoMode/videos"

    # Elvis The Alien.
    "https://www.youtube.com/@ElvistheAlien/videos"
)

# Download parameters.
PLAYLIST_END=5
DOWNLOAD_N=8
DOWNLOAD_ARCHIVE_MUSIC=".archivemusic"
DOWNLOAD_ARCHIVE_AUDIO=".archiveaudio"
DOWNLOAD_ARCHIVE_VIDEO=".archivevideo"
DOWNLOAD_COOKIES_FROM_BROWSER="firefox"

# Audio parameters.
AUDIO_FORMAT="mp3"

# AMV parameters (default values: 240x320, 30fps, rotated clockwise 90 degrees).
WIDTH=240
HEIGHT=320
FPS=30

# Export the variables so they can be used in other scripts.
export URLS_MUSIC
export URLS_AUDIO
export URLS_VIDEO
export PLAYLIST_END
export DOWNLOAD_N
export DOWNLOAD_ARCHIVE_MUSIC
export DOWNLOAD_ARCHIVE_AUDIO
export DOWNLOAD_ARCHIVE_VIDEO
export DOWNLOAD_COOKIES_FROM_BROWSER
export AUDIO_FORMAT
export WIDTH
export HEIGHT
export FPS
export ROTATE