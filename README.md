# video

Experiment (March-April 2022): generate a short promotional video from product information. The worked example is a real-estate listing: photos plus a description become a narrated slideshow with zoom/pan, background music and a text overlay, using `ffmpeg`, Google Cloud Text-to-Speech and a few Ruby and shell scripts.

**Status and stance:** archived experiment. Not maintained since April 2022, not tested on current tool versions, and pull requests are not expected. Use at your own risk. The code is MIT-licensed (see `LICENSE`).

**This repo ships code only.** An earlier version also contained a scraped real-estate dataset, listing photos, generated narration and rendered video. That material belongs to third parties, so it has been removed from the repository (and from its history). You supply your own inputs, as described below.

## What is here

| Path | What it does |
|---|---|
| `src/steps.md` | The manual pipeline, step by step |
| `src/fetch_images.rb` | Downloads numbered images from a base URL you pass in |
| `src/gspeech.cmd.sh`, `src/gspeech.input.json` | Calls Google Cloud Text-to-Speech (sample input text only) |
| `src/process_audio.rb`, `src/audio-mix.cmd` | Pads the narration and mixes it with background music |
| `src/ffmpeg-*.cmd` | `ffmpeg` recipes: image slideshow, zoom/pan, concat with audio, trim, crop, text overlay |
| `src/utils.rb`, `src/test.rb` | Small Ruby helper for the text overlay and a smoke test |
| `src/trulia_data.rb` | Extracts feature sentences from a real-estate dataset CSV for narration |
| `src/fetch_yelp.rb` | Experiment with the Yelp Fusion API (reads a local key file) |

## Bring your own data

Scripts expect a per-listing folder under `properties/<name>/` (gitignored, so nothing you put there is committed):

```
properties/<name>/
  images/       01.jpg, 02.jpg, ...      your photos, or images you are licensed to reuse
  description/  summary.txt, highlights.txt, font.ttf
  audio/        background.mp3           music you are licensed to use
  temp/ out/                             created and filled by the scripts
```

- **Images and text:** use your own listing or product material. `fetch_images.rb <image_base_url> [count]` only downloads from a URL you give it; do not use it on content you have no right to reuse.
- **Narration:** write a text, put it in `src/gspeech.input.json` style input, and run `src/gspeech.cmd.sh -p <name>` (needs the `gcloud` CLI and a Google Cloud project with the Text-to-Speech API; the text is sent to Google). Alternatively `src/ffmpeg-tts-flite.cmd <name>` works offline if your `ffmpeg` has `flite`.
- **Music:** any track you have rights to, saved as `audio/background.mp3`.
- **Font:** download a font such as Amaranth (SIL Open Font License) from Google Fonts and save it as `common/font.ttf` and `properties/<name>/description/font.ttf`. Both paths are gitignored.
- **Dataset (optional, for `trulia_data.rb`):** the original experiment used the "Real Estate Data from Trulia" dataset on Kaggle (reference 5 below). It is not included. If you download it, check its terms, save it as `properties/trulia_dataset.csv`, and note that it contains addresses and real estate agents' names and phone numbers; do not republish it.
- **Yelp (optional):** `fetch_yelp.rb` reads a Yelp Fusion API key from `conf/yelp.cred` (gitignored) as `{"apiKey": "..."}`.

## Running it

Prerequisites: `ffmpeg` and `ffprobe`, Ruby with the `down` and `yelp-fusion` gems (there is no Gemfile), and for narration the `gcloud` CLI. Then follow `src/steps.md`; most scripts take `-p <name>`. Nothing in the pipeline was ever automated end to end, and the scripts were last run in 2022 on macOS and Linux.

## Data flows

Running the scripts sends: narration text to Google Cloud Text-to-Speech, search terms to Yelp (with your key), and image requests to the URL you give `fetch_images.rb`. The repository itself does not collect or send anything.

## Third-party notes

Several `ffmpeg` commands were adapted from Stack Exchange answers; the source URL is in a comment in each file and the original answers carry their own (CC BY-SA) terms. Generated text-to-speech audio, music and images are not part of this repo.

## References
1. ffmpeg.org
2. Google AutoML
  1. https://cloud.google.com/natural-language/automl/docs/beginners-guide?hl=en
  2. https://www.youtube.com/watch?v=mawZ6EUOmcY
  3. https://cloud.google.com/solutions/datasets
  4. https://github.com/GoogleCloudPlatform/public-datasets-pipelines/releases
  5. https://www.kaggle.com/datasets/promptcloud/real-estate-data-from-trulia?resource=download
