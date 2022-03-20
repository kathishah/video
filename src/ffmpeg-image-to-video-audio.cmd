#!/bin/bash

MY_NAME=`basename $0`
TS=`date +%Y-%m-%d-%H-%M-%S`
OUTPUT=out/$MY_NAME.$TS.mp4
echo $OUTPUT

# https://superuser.com/questions/833232/create-video-with-5-images-with-fadein-out-effect-in-ffmpeg
ffmpeg \
-loop 1 -t 3 -i images/01.jpg \
-loop 1 -t 3 -i images/02.jpg \
-loop 1 -t 3 -i images/03.jpg \
-loop 1 -t 3 -i images/04.jpg \
-loop 1 -t 3 -i images/05.jpg \
-i audio/background.mp3 \
-filter_complex \
"[0:v]scale=1440:960:force_original_aspect_ratio=decrease,pad=1440:960:(ow-iw)/2:(oh-ih)/2,setsar=1,fade=t=out:st=4:d=1[v0]; \
 [1:v]scale=1440:960:force_original_aspect_ratio=decrease,pad=1440:960:(ow-iw)/2:(oh-ih)/2,setsar=1,fade=t=in:st=0:d=1,fade=t=out:st=4:d=1[v1]; \
 [2:v]scale=1440:960:force_original_aspect_ratio=decrease,pad=1440:960:(ow-iw)/2:(oh-ih)/2,setsar=1,fade=t=in:st=0:d=1,fade=t=out:st=4:d=1[v2]; \
 [3:v]scale=1440:960:force_original_aspect_ratio=decrease,pad=1440:960:(ow-iw)/2:(oh-ih)/2,setsar=1,fade=t=in:st=0:d=1,fade=t=out:st=4:d=1[v3]; \
 [4:v]scale=1440:960:force_original_aspect_ratio=decrease,pad=1440:960:(ow-iw)/2:(oh-ih)/2,setsar=1,fade=t=in:st=0:d=1,fade=t=out:st=4:d=1[v4]; \
 [v0][v1][v2][v3][v4]concat=n=5:v=1:a=0,format=yuv420p[v]" \
-map "[v]" -map 5:a -shortest $OUTPUT
