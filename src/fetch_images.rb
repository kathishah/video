#!/usr/bin/env ruby

# Download numbered listing images (1.jpg, 2.jpg, ...) into ./images.
#
# Usage: fetch_images.rb <image_base_url> [count]
#   image_base_url  URL prefix; the image number is appended to it
#   count           how many images to fetch (default 18)
#
# Only download images you have the right to use (your own listings or
# photos you are licensed to reuse). The base URL is not stored in this repo.

require "down"
require "fileutils"

IMAGES_DIR = "./images"

image_cdn_url = ARGV[0]
count = (ARGV[1] || 18).to_i
abort "Usage: #{$0} <image_base_url> [count]" unless image_cdn_url

#create sub directory
puts "checking for #{IMAGES_DIR}"
FileUtils.mkdir_p(IMAGES_DIR)

for i in 1..count do
  full_url = image_cdn_url + "%d" % [i]
  puts "Downloading #{full_url}...."
  fname = "#{IMAGES_DIR}/%02d.jpg" % [i]
  temp_file = Down.download(full_url)
  puts "\t=>#{fname}"
  FileUtils.mv(temp_file.path, "./#{fname}")
end
