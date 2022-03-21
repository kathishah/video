#!/bin/bash

# trying two at the same time

ffmpeg \
    -framerate 25 \
    -i ../properties/P01-ML81883042/images/12.jpg \
    -i ../properties/P01-ML81883042/images/16.jpg \
    -filter_complex \
        "[0:v]scale=-2:10*ih,zoompan=z='min(zoom+0.0015,1.5)':d=125:x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)',scale=-2:720[v0]; \
         [1:v]scale=-2:10*ih,zoompan=z='min(zoom+0.0005,1.5)':d=125:x='x':y='if(gte(zoom,1.5),y,y+1)',scale=-2:720[v1]; \
         [v0][v1]concat=n=2:v=1:a=0,format=yuv420p[v]" \
    -y -map "[v]" ../properties/P01-ML81883042/out/zoom-pan-12-16.mp4
