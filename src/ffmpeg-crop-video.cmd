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
echo "trimmed filename: ${OUTPUT_FILE_NAME}"
OUTPUT="${PROPERTY_DIR}/temp/cropped_${OUTPUT_FILE_NAME}.mp4"
echo "Reading $PROPERTY_DIR/temp/$INPUT_FILE"
echo "Generating $OUTPUT..."

#
# https://video.stackexchange.com/questions/4563/how-can-i-crop-a-video-with-ffmpeg 
ffmpeg \
-i "$PROPERTY_DIR/temp/$INPUT_FILE" \
-filter:v "crop=in_w-200:in_h" \
-c:a copy $OUTPUT
