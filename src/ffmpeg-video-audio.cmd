!#/bin/bash

ASSET_DIR="/home/chintan/dev/video/properties/P01-ML81883042"
ffmpeg \
    -stream_loop -1 -f concat \
    -i ffmpeg-video-audio.input \
    -i $ASSET_DIR/out/out-audio-mix.mp3 \
    -map 0:v -map 1:a -shortest $ASSET_DIR/out/videos_with_audio.mp4

