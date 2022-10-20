#!/bin/bash

set -euo pipefail
source $(dirname $0)/var.sh

FLAGS=(
  "${FFMPEG_CONFIG_FLAGS_BASE[@]}"
  --enable-libx264         # required by fdk-aac
  --enable-gpl
#  --enable-libwavpack     # enable libwavpack
#  --enable-libmp3lame     # enable libmp3lame
#  --enable-libfdk-aac     # enable libfdk-aac
#  --enable-libvorbis      # enable libvorbis
#  --enable-libopus        # enable opus
)
echo "FFMPEG_CONFIG_FLAGS=${FLAGS[@]}"
emconfigure ./configure "${FLAGS[@]}"
