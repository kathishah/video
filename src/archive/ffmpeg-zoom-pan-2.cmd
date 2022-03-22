#!/bin/bash

# https://superuser.com/questions/833232/create-video-with-5-images-with-fadein-out-effect-in-ffmpeg
#ffmpeg -f lavfi -i color=#000000:1440x960:r=30:d=10 \
ffmpeg \
-loop 1 -t 3 -i images/01.jpg \
-loop 1 -t 3 -i images/02.jpg \
-filter_complex \
"[0:v]zoompan=z='min(zoom+0.0015,2.5)':x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)',fade=t=out:d=70:fps=30[v0]; \
 [1:v]zoompan=z='min(zoom+0.0015,1.5)':x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)',fade=t=in:d=70:fade=t=out:fps=30[v1]; \
 [v0][v1]concat=n=2:v=1:a=0,format=yuv420p[v]" \
-map "[v]" out-zoom-pan-2.mp4
