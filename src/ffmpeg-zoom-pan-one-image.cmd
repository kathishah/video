#!/bin/bash

ffmpeg \
    -framerate 25 \
    -i ../properties/P01-ML81883042/images/12.jpg \
    -filter_complex \
        "scale=-2:10*ih,zoompan=z='min(zoom+0.0015,1.5)':d=125:x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)',scale=-2:720" \
    -y -shortest -c:v libx264 ../properties/P01-ML81883042/out/zoom-pan-12.mp4
