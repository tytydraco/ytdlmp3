#!/usr/bin/env bash

case "$1" in
    build)
        docker build --no-cache -t ytdlmp3:latest .
        ;;
    run)
        docker run \
            --rm \
            -it \
            --user "$(id -u):$(id -g)" \
            -v "$PWD:/app" \
            -v "$HOME/.mozilla/firefox:/home/ubuntu/.mozilla/firefox:ro" \
            --workdir /app \
            ytdlmp3:latest \
            bash main.sh
        ;;
    clean)
        docker rmi ytdlmp3:latest
        ;;
    *)
        echo "Usage: $0 <build|run|clean>"
        exit 1
        ;;
esac