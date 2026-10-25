#!/bin/bash

# http://johnriselvato.com/ffmpeg-how-to-generate-text-to-speech-audio/
# Usage: ffmpeg-tts-flite.cmd <property_name>

PROPERTY=${1:?Usage: $0 <property_name>}
PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PROPERTY_DIR="$PROJECT_ROOT/properties/$PROPERTY"

ffmpeg -f lavfi -i "flite=textfile=$PROPERTY_DIR/description/summary.txt" "$PROPERTY_DIR/audio/tts-summary.txt.mp3"
