#!/bin/bash

usage() { echo "Usage: $0 [-p <property_name>] [-f <input_file?>]" 1>&2; exit 1; }

while getopts ":p:f:" o; do
    case "${o}" in
        p)
            PROPERTY=${OPTARG}
            ;;
        f)
            INPUT_FILE=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "${PROPERTY}" ] || [ -z "#{INPUT_FILE}" ]; then
    usage
fi

echo "property = ${PROPERTY}"
PROPERTY_DIR="/home/chintan/dev/video/properties/$PROPERTY"

OUTPUT_FILE_NAME=${INPUT_FILE%.*} 
OUTPUT="$PROPERTY_DIR/temp/$OUTPUT_FILE_NAME-with-text.mp4"
echo "Reading $PROPERTY_DIR/temp/$INPUT_FILE"
echo "Generating $OUTPUT..."

#
# https://stackoverflow.com/questions/17623676/text-on-video-ffmpeg
ffmpeg \
-i "$PROPERTY_DIR/temp/$INPUT_FILE" \
-vf "drawtext=fontfile=$PROPERTY_DIR/description/font.ttf:textfile=$PROPERTY_DIR/description/highlights.txt:fontcolor=white:fontsize=36:x=w-tw-100:y=h-th-10" \
-codec:a copy $OUTPUT
