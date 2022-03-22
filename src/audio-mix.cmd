#!/bin/bash

# https://stackoverflow.com/questions/14498539/how-to-overlay-downmix-two-audio-files-using-ffmpeg

ffmpeg \
    -i ../properties/P01-EXAMPLE/audio/background.mp3 \
    -i ../properties/P01-EXAMPLE/audio/gspeech.out.mp3 \
    -filter_complex amix=inputs=2:duration=longest output.mp3
