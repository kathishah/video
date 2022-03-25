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

# https://stackoverflow.com/questions/46508055/using-ffmpeg-to-cut-audio-from-to-position

ASSET_DIR=$PROPERTY_DIR
ffmpeg \
    -t 29 \
    -i $ASSET_DIR/temp/videos_with_audio.mp4 \
    -c copy -y $ASSET_DIR/temp/trimmed_video_with_audio.mp4

