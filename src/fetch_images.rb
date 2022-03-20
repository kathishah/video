#!/usr/bin/env ruby

require "down"
require "fileutils"

# https://www.mlslistings.com/property/ml81883042/1434-virginia-ave-redwood-city-ca-94061/15285933 

IMAGES_DIR="./images"

image_cdn_url="https://mlslmedia.azureedge.net/property/MLSL/81883042/7019041db9de47e9a0d7810c06879e9e/2/"

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
