#!/bin/bash

# https://stackoverflow.com/questions/54266237/ffmpeg-zoom-pan-multiple-images

ffmpeg -f lavfi -i color=#000000:1440x960:r=30:d=10 \
       -f lavfi -t 10 
       -i "images/01.jpg" \
       -i "images/02.jpg" \
       -filter_complex \
         "[1:v]scale=4455:2506:force_original_aspect_ratio=increase,zoompan=z='min(zoom+0.0015,2.5)':x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':d=150:fps=30[v1]; \
         [2:v]scale=3840:2160:force_original_aspect_ratio=increase,zoompan=z='min(zoom+0.0015,2.5)':x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':d=150:fps=30[v2]; \
         [v1][v2]concat=n=5:v=1:a=0,format=yuv420p[v]" \
        -map "[v]" output.mp4
