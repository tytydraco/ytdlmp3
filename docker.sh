#!/usr/bin/env bash

SCRIPT_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

case "$1" in
    build)
        docker build \
            --no-cache \
            --tag ytdlmp3:latest \
            .
        ;;
    run)
        docker run \
            --rm \
            --user "$(id -u):$(id -g)" \
            -e HOME="$HOME" \
            --name ytdlmp3 \
            --interactive \
            --tty \
            --volume "$SCRIPT_DIR:/app" \
            --volume "$HOME:$HOME:ro" \
            ytdlmp3:latest
        ;;
    clean)
        docker image rm ytdlmp3:latest
        ;;
    *)
        echo "Usage: $0 <build|run|clean>"
        exit 1
        ;;
esac