#!/bin/bash

set -euo pipefail
source $(dirname $0)/var.sh

FLAGS=(
  -I. -I./fftools -I$BUILD_DIR/include
  -Llibavcodec -Llibavdevice -Llibavfilter -Llibavformat -Llibavresample -Llibavutil -Llibass -Llibpostproc -Llibswscale -Llibswresample -L$BUILD_DIR/lib
  -Wno-deprecated-declarations -Wno-pointer-sign -Wno-implicit-int-float-conversion -Wno-switch -Wno-parentheses -Qunused-arguments
  -lavdevice -lavfilter -lavformat -lavcodec -lswresample -lavutil -lm -lwavpack -lmp3lame -lfdk-aac -lvorbis -lvorbisenc -lvorbisfile -logg -lopus
  fftools/ffmpeg_opt.c fftools/ffmpeg_filter.c fftools/ffmpeg_hw.c fftools/cmdutils.c fftools/ffmpeg.c
  -s USE_SDL=2                                  # use SDL2
  -s INVOKE_RUN=0                               # not to run the main() in the beginning
  -s EXIT_RUNTIME=1                             # exit runtime after execution
  -s MODULARIZE=1                               # use modularized version to be more flexible
  -s EXPORT_NAME="createFFmpegCore"             # assign export name for browser
  -s EXPORTED_FUNCTIONS="[_main]"  # export main and proxy_main funcs
  -s EXPORTED_RUNTIME_METHODS="[FS, cwrap, ccall, setValue, writeAsciiToMemory]"   # export preamble funcs
  -s INITIAL_MEMORY=2146435072                  # 64 KB * 1024 * 16 * 2047 = 2146435072 bytes ~= 2 GB
  -s ASSERTIONS=1
  --pre-js wasm/src/pre.js
  --post-js wasm/src/post.js
  $OPTIM_FLAGS
  ${EXTRA_FLAGS[@]}
)
echo "FFMPEG_CONFIG_FLAGS=${FLAGS[@]}"
emconfigure ./configure "${FLAGS[@]}"
