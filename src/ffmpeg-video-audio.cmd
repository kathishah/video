#!/bin/bash

usage() { echo "Usage: $0 [-p <property_name>]" 1>&2; exit 1; }

while getopts ":p:" o; do
    case "${o}" in
        p)
            PROPERTY=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "${PROPERTY}" ]; then
    usage
fi

echo "property = ${PROPERTY}"
PROPERTY_DIR="/home/chintan/dev/video/properties/$PROPERTY"

# https://trac.ffmpeg.org/wiki/Concatenate
# https://stackoverflow.com/questions/63704692/merge-multiple-videos-and-one-audio-with-ffmpeg-loop-all-the-videos-while-audio

ASSET_DIR=$PROPERTY_DIR
ffmpeg \
    -stream_loop -1 -f concat \
    -i ffmpeg-video-audio.input \
    -i $ASSET_DIR/audio/out-audio-mix.mp3 \
    -map 0:v -map 1:a -shortest $ASSET_DIR/temp/videos_with_audio.mp4

