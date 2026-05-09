FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Bash is required to be the default shell.
RUN ln -sfv /bin/bash /bin/sh

RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get install -y --no-install-recommends \
    curl \
    p7zip-full \
    ffmpeg \
    nodejs \
    npm \
    aria2 \
    python3 \
    python3-pip \
    python3-venv \
    wine \
    wine64 \
    winbind \
    wine32:i386

RUN pip3 install --break-system-packages --no-cache-dir yt-dlp yt-dlp-ejs

# Deno for EJS captcha solving.
ENV DENO_INSTALL=/usr/local
RUN curl -fsSL https://deno.land/install.sh | sh
ENV PATH="${DENO_INSTALL}/bin:${PATH}"

WORKDIR /app