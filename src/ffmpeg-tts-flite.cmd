#!/bin/bash

# http://johnriselvato.com/ffmpeg-how-to-generate-text-to-speech-audio/

ffmpeg -f lavfi -i "flite=textfile=../properties/P01-ML81883042/description/summary.txt" ../properties/P01-ML81883042/audio/tts-summary.txt.mp3
