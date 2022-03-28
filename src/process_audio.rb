#!/usr/bin/env ruby

require 'getoptlong'

opts = GetoptLong.new(
        ['--help', '-h', GetoptLong::NO_ARGUMENT],
        ['--property', '-p', GetoptLong::REQUIRED_ARGUMENT],
        ['--no-op', '-n', GetoptLong::NO_ARGUMENT]
       )
property = nil
noop = false
opts.each do |opt, arg|
  case opt
  when '--help'
    puts "-p|--property <property_name>"
  when '--property'
    property = arg
  when '--no-op'
    noop = true
  end
end

unless property
  puts "Missing property name. See help"
  exit 0
end

PROPERTY_NAME=property
BASE_DIR=Dir::home + "/dev/video/properties/#{PROPERTY_NAME}"
puts "Executing in #{BASE_DIR}"
puts "1. left pad gspeech..."
left_pad_gspeech_cmd = "ffmpeg -i #{BASE_DIR}/audio/gspeech.out.mp3 -af \"adelay=2000|2000\" -y #{BASE_DIR}/audio/gspeech.left_padded.mp3"
puts "\t#{left_pad_gspeech_cmd}"
unless noop
  left_pad_cmd_out = %x[#{left_pad_gspeech_cmd}]
  left_pad_cmd_exitstatus = $?.exitstatus
  puts "\tExecuted left padding: #{left_pad_cmd_exitstatus}"
else
  puts "\tNOOP"
end


# https://stackoverflow.com/questions/6239350/how-to-extract-duration-time-from-ffmpeg-output
FFPROBE_CMD = "ffprobe -i FILE_PATH -show_entries format=duration -v quiet -of csv=\"p=0\""
puts "2. finding length of audio files..."

file_path_gspeech = "#{BASE_DIR}/audio/gspeech.left_padded.mp3" 
gspeech_cmd = FFPROBE_CMD.sub(/FILE_PATH/,file_path_gspeech)
puts "\t#{gspeech_cmd}"
unless noop
  length_gspeech=%x[#{gspeech_cmd}]
  puts "\tlength of gspeech = #{length_gspeech}"
else
  length_gspeech = 0
  puts "\tNOOP"
end

file_path_background="#{BASE_DIR}/audio/background.mp3"
background_cmd=FFPROBE_CMD.sub(/FILE_PATH/, file_path_background)
puts "\t#{background_cmd}"
unless noop
  length_background=%x[#{background_cmd}]
  puts "length of background = #{length_background}"
else
  length_background = 0
  puts "\tNOOP"
end

# https://superuser.com/questions/579008/add-1-second-of-silence-to-audio-through-ffmpeg
padding = length_background.to_i - length_gspeech.to_i + 1
puts "3. Padding to be added: #{padding}"

PADDING_CMD = "ffmpeg -i INPUT1 -af \"apad=pad_dur=PAD\" OUTPUT"
padding_cmd_final = PADDING_CMD.sub(/INPUT1/,file_path_gspeech).sub(/PAD/,padding.to_s).sub(/OUTPUT/,"#{BASE_DIR}/audio/gspeech.padded.mp3")
puts "4. Adding padding..."
puts "\t#{padding_cmd_final}"
unless noop
  padding_cmd_out = %x[#{padding_cmd_final}]
  padding_cmd_exitstatus = $?.exitstatus
  puts "Executed padding: #{padding_cmd_exitstatus}"
else
  puts "\tNOOP"
end
