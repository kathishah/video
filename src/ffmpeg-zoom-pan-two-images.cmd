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

# trying two at the same time

ffmpeg \
    -framerate 25 \
    -i $PROPERTY_DIR/images/12.jpg \
    -i $PROPERTY_DIR/images/16.jpg \
    -filter_complex \
        "[0:v]scale=-2:10*ih,zoompan=z='min(zoom+0.0015,1.5)':d=125:x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)',scale=-2:720[v0]; \
         [1:v]scale=-2:10*ih,zoompan=z='min(zoom+0.0005,1.5)':d=125:x='x':y='if(gte(zoom,1.5),y,y+1)',scale=-2:720[v1]; \
         [v0][v1]concat=n=2:v=1:a=0,format=yuv420p[v]" \
    -y -map "[v]" $PROPERTY_DIR/temp/zoom-pan-12-16.mp4
