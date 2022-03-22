#!/bin/bash

# https://superuser.com/questions/1506050/ffmpeg-image-size-based-pan-zoom

# ffmpeg -i images/01.jpg \
#   -filter_complex \
#     "pad=w=iw*3:h=ih*1.7:x='(ow-iw)/2':y='(oh-ih)/2',\
#     zoompan=x='(iw-0.625*ih)/2':y='(on/(25*85))*(ih-ih/zoom)'\
#     :z='4':d=25*85:s=720x480" \
#   -pix_fmt yuv420p -c:v libx264 out-zoom-pan-3.mp4

ffmpeg -i images/01.jpg \
    -filter_complex \
        "zoompan=z='min(zoom+0.0015,1.5)':d=70:x='if(gte(zoom,1.5),x,x+1/a)':y='if(gte(zoom,1.5),y,y+1)':s=640x360" \
    -pix_fmt yuv420p -c:v libx264 out-zoom-pan-3.mp4
