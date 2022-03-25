#!/bin/bash

# https://cloud.google.com/text-to-speech
# https://cloud.google.com/text-to-speech/docs/basics
# https://cloud.google.com/text-to-speech/docs/base64-decoding#linux

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

curl -H "Authorization: Bearer "$(gcloud auth application-default print-access-token) -H "Content-Type: application/json; charset=utf-8" --data @$PROPERTY_DIR/temp/gspeech.input.json -o "$PROPERTY_DIR/temp/gspeech.out.json" "https://texttospeech.googleapis.com/v1/text:synthesize"

## extract audio content
# jq .audioContent $PROPERTY_DIR/temp/gspeech.out.json | sed -e 's/"//g' > $PROPERTY_DIR/temp/gspeech.base64
## base64 decode into mp3
# base64 $PROPERTY_DIR/temp/gspeech.base64 -d $PROPERTY_DIR/audio/gspeech.out.mp3
