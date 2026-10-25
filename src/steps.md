
1. Download the images (only ones you may use): fetch_images.rb <image_base_url> [count], run from properties/<name>/
1. Get the description text: _manual_ (write your own or use text you are licensed to use)
1. Get audio description
    1. Create input json: _manual_ gspeech.input.json
    1. Call gspeech API: gspeech.cmd
    1. Parse output and base64 decode: _manual_ with base64 util
1. Mix background audio with gspeech narrative: 
    1. Pad gspeech as necessary: process_audio.rb
    1. Mix the two: audio-mix.cmd
1. Video
    1. Take first 5 images and create a video with simple fade in/out:  ffmpeg-image-to-video.cmd
    1. Take a couple of random images from the higher numbers and create video with zoom/pan: ffmpeg-zoom-pan-two-images.cmd
    1. Concat these two videos with audio: ffmpeg-video-audio.cmd
    1. Trim the video to 30 secs: ffmpeg-trim-video.cmd
    1. Add text description: ffmpeg-add-text.cmd
    1. Trim the side bars: ffmpeg-crop-video.cmd

