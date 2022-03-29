#!/usr/bin/env ruby

require_relative 'utils'

#class Test
#  include Utils
#end

puts "including... #{Object.included_modules}"
puts "methods: #{Utils.public_methods}"

PROPERTY_NAME = "P01-ML81883042"
base_dir = Dir::home + "/dev/video/properties/#{PROPERTY_NAME}"

exit_status = Utils.add_text(base_dir + "/out/zoom-pan-12.mp4", base_dir + "/description/highlights.txt", "w-tw-100", "h-th-10", base_dir + "/out/chintan.mp4")

puts "Done: #{exit_status}"
