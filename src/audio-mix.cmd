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


# https://stackoverflow.com/questions/14498539/how-to-overlay-downmix-two-audio-files-using-ffmpeg

ffmpeg \
    -i $PROPERTY_DIR/audio/background.mp3 \
    -i $PROPERTY_DIR/audio/gspeech.padded.mp3 \
    -filter_complex \
        "[1:a]asplit=2[sc][mix]; \
         [0:a][sc]sidechaincompress=threshold=0.003:ratio=20[bg]; \
         [bg][mix]amerge[final]" \
    -map [final] -y $PROPERTY_DIR/audio/out-audio-mix.mp3
