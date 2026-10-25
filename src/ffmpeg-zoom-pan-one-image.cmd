#!/bin/bash

# References
# https://superuser.com/questions/1127615/ffmpeg-zoompan-filter-examples
# https://superuser.com/questions/1087685/ffmpeg-zoompan-image-to-center-position
# Usage: ffmpeg-zoom-pan-one-image.cmd <property_name> [image_number]

PROPERTY=${1:?Usage: $0 <property_name> [image_number]}
IMAGE=${2:-12}
PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PROPERTY_DIR="$PROJECT_ROOT/properties/$PROPERTY"

ffmpeg \
    -framerate 25 \
    -i "$PROPERTY_DIR/images/$IMAGE.jpg" \
    -filter_complex \
        "scale=-2:10*ih,zoompan=z='min(zoom+0.0015,1.5)':d=125:x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)',scale=-2:720" \
    -y -shortest -c:v libx264 "$PROPERTY_DIR/out/zoom-pan-$IMAGE.mp4"
