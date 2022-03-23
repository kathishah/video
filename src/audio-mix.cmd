#!/bin/bash


# https://stackoverflow.com/questions/14498539/how-to-overlay-downmix-two-audio-files-using-ffmpeg

ffmpeg \
    -i ../properties/P01-ML81883042/audio/background.mp3 \
    -i ../properties/P01-ML81883042/audio/gspeech.padded.mp3 \
    -filter_complex \
        "[1:a]asplit=2[sc][mix]; \
         [0:a][sc]sidechaincompress=threshold=0.003:ratio=20[bg]; \
         [bg][mix]amerge[final]" \
    -map [final] -y out-audio-mix.mp3
