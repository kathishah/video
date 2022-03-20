#!/bin/bash

MY_NAME=`basename $0`
TS=`date +%Y-%m-%d-%H-%M-%S`
OUTPUT=out/$MY_NAME.$TS.mp4
echo "Generating $OUTPUT..."

# https://stackoverflow.com/questions/17623676/text-on-video-ffmpeg
ffmpeg \
-i $1 \
-vf "drawtext=fontfile=description/font.ttf:textfile=description/highlights.txt:fontcolor=white:fontsize=36:x=w-tw-10:y=h-th-10" \
-codec:a copy $OUTPUT
