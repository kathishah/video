#!/bin/bash

# https://cloud.google.com/text-to-speech

curl -H "Authorization: Bearer "$(gcloud auth application-default print-access-token) -H "Content-Type: application/json; charset=utf-8" --data @./gspeech.input.json -o "../properties/P01-EXAMPLE/audio/gspeech.out.mp3" "https://texttospeech.googleapis.com/v1/text:synthesize"

