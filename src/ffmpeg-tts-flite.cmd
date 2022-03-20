#!/bin/bash

# http://johnriselvato.com/ffmpeg-how-to-generate-text-to-speech-audio/

ffmpeg -f lavfi -i "flite=textfile=../properties/P01-EXAMPLE/description/summary.txt" ../properties/P01-EXAMPLE/audio/tts-summary.txt.mp3
