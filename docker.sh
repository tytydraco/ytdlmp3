#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

case "$1" in
    build)
        docker build \
            --no-cache \
            --tag ytdlmp3:latest \
            .
        ;;
    run)
        docker run \
            --name ytdlmp3 \
            --interactive \
            --tty \
            --volume "$HOME/.mozilla/firefox:/root/.mozilla/firefox:ro" \
            --volume "$SCRIPT_DIR/config.sh:/app/config.sh:ro" \
            ytdlmp3:latest
        docker cp ytdlmp3:/app/out docker_out
        docker rm -f ytdlmp3
        ;;
    clean)
        docker image rm ytdlmp3:latest
        ;;
    *)
        echo "Usage: $0 <build|run|clean>"
        exit 1
        ;;
esac