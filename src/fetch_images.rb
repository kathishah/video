#!/usr/bin/env ruby

require "down"
require "fileutils"

# https://example.com/listing 

IMAGES_DIR="./images"

image_cdn_url="https://example.com/images/"

#create sub directory 
puts "checking for #{IMAGES_DIR}"
FileUtils.mkdir_p(IMAGES_DIR)

for i in 1..18 do
  full_url = image_cdn_url + "%d" % [i]
  puts "Downloading #{full_url}...."
  fname = "#{IMAGES_DIR}/%02d.jpg" % [i]
  temp_file = Down.download(full_url)
  puts "\t=>#{fname}"
  FileUtils.mv(temp_file.path, "./#{fname}")
end
