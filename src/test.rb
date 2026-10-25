#!/usr/bin/env ruby

# Smoke test for Utils.add_text. Usage: test.rb <property_name>
# Expects properties/<property_name>/out/zoom-pan-12.mp4 and
# properties/<property_name>/description/highlights.txt to exist.

require_relative 'utils'

#class Test
#  include Utils
#end

puts "including... #{Object.included_modules}"
puts "methods: #{Utils.public_methods}"

PROPERTY_NAME = ARGV[0] or abort "Usage: #{$0} <property_name>"
base_dir = File.expand_path("../properties/#{PROPERTY_NAME}", __dir__)

exit_status = Utils.add_text(base_dir + "/out/zoom-pan-12.mp4", base_dir + "/description/highlights.txt", "w-tw-100", "h-th-10", base_dir + "/out/with-text.mp4")

puts "Done: #{exit_status}"
