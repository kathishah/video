!#/bin/bash

# https://stackoverflow.com/questions/46508055/using-ffmpeg-to-cut-audio-from-to-position

ASSET_DIR="/home/chintan/dev/video/properties/P01-ML81883042"
ffmpeg \
    -t 30 \
    -i videos_with_audio.mp4 \
    -c copy -y trimmed_video_with_audio.mp4

