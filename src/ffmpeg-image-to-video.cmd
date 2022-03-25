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
ASSET_DIR=$PROPERTY_DIR

# https://superuser.com/questions/833232/create-video-with-5-images-with-fadein-out-effect-in-ffmpeg
ffmpeg \
-loop 1 -t 3 -i $ASSET_DIR/images/01.jpg \
-loop 1 -t 3 -i $ASSET_DIR/images/02.jpg \
-loop 1 -t 3 -i $ASSET_DIR/images/03.jpg \
-loop 1 -t 3 -i $ASSET_DIR/images/04.jpg \
-loop 1 -t 3 -i $ASSET_DIR/images/05.jpg \
-filter_complex \
"[0:v]scale=1280:720:force_original_aspect_ratio=decrease,pad=1280:720:(ow-iw)/2:(oh-ih)/2,setsar=1,fade=t=out:st=4:d=1[v0]; \
 [1:v]scale=1280:720:force_original_aspect_ratio=decrease,pad=1280:720:(ow-iw)/2:(oh-ih)/2,setsar=1,fade=t=in:st=0:d=1,fade=t=out:st=4:d=1[v1]; \
 [2:v]scale=1280:720:force_original_aspect_ratio=decrease,pad=1280:720:(ow-iw)/2:(oh-ih)/2,setsar=1,fade=t=in:st=0:d=1,fade=t=out:st=4:d=1[v2]; \
 [3:v]scale=1280:720:force_original_aspect_ratio=decrease,pad=1280:720:(ow-iw)/2:(oh-ih)/2,setsar=1,fade=t=in:st=0:d=1,fade=t=out:st=4:d=1[v3]; \
 [4:v]scale=1280:720:force_original_aspect_ratio=decrease,pad=1280:720:(ow-iw)/2:(oh-ih)/2,setsar=1,fade=t=in:st=0:d=1,fade=t=out:st=4:d=1[v4]; \
 [v0][v1][v2][v3][v4]concat=n=5:v=1:a=0,format=yuv420p[v]" \
-map "[v]" -y $ASSET_DIR/temp/video_from_image_transition.mp4
