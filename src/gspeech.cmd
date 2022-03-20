#!/bin/bash

curl -H "Authorization: Bearer "$(gcloud auth application-default print-access-token) -H "Content-Type: application/json; charset=utf-8" \ 
    -d @gspeech.input.json \
    "https://texttospeech.googleapis.com/v1/text:synthesize"

