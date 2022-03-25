#!/usr/bin/env ruby

require 'getoptlong'

opts = GetoptLong.new(
        ['--help', '-h', GetoptLong::NO_ARGUMENT],
        ['--property', '-p', GetoptLong::REQUIRED_ARGUMENT]
       )
property = nil
opts.each do |opt, arg|
  case opt
  when '--help'
    puts "-p|--property <property_name>"
  when '--property'
    property = arg
  end
end

unless property
  puts "Missing property name. See help"
end

PROPERTY_NAME=property
BASE_DIR="/home/chintan/dev/video/properties/#{PROPERTY_NAME}"
puts BASE_DIR
exit 0

# https://stackoverflow.com/questions/6239350/how-to-extract-duration-time-from-ffmpeg-output
FFPROBE_CMD = "ffprobe -i FILE_PATH -show_entries format=duration -v quiet -of csv=\"p=0\""
puts FFPROBE_CMD

file_path_gspeech = "#{BASE_DIR}/audio/gspeech.out.mp3" 
gspeech_cmd = FFPROBE_CMD.sub(/FILE_PATH/,file_path_gspeech)
length_gspeech=%x[#{gspeech_cmd}]
puts "length of gspeech = #{length_gspeech}"

file_path_background="#{BASE_DIR}/audio/background.mp3"
background_cmd=FFPROBE_CMD.sub(/FILE_PATH/, file_path_background)
length_background=%x[#{background_cmd}]
puts "length of background = #{length_background}"

# https://superuser.com/questions/579008/add-1-second-of-silence-to-audio-through-ffmpeg
padding = length_background.to_i - length_gspeech.to_i + 1
puts "adding padding #{padding}"

PADDING_CMD = "ffmpeg -i INPUT1 -af \"apad=pad_dur=PAD\" OUTPUT"
padding_cmd_final = PADDING_CMD.sub(/INPUT1/,file_path_gspeech).sub(/PAD/,padding.to_s).sub(/OUTPUT/,"#{BASE_DIR}/audio/gspeech.padded.mp3")
puts "padding: #{padding_cmd_final}"

padding_cmd_out = %x[#{padding_cmd_final}]
padding_cmd_exitstatus = $?.exitstatus
puts "Executed padding: #{padding_cmd_exitstatus}"
