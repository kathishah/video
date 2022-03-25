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
  exit 0
end

PROPERTY_NAME=property
BASE_DIR="/home/chintan/dev/video/properties/#{PROPERTY_NAME}"
puts "Executing in #{BASE_DIR}"

puts "1. left pad gspeech..."
left_pad_gspeech_cmd = "ffmpeg -i #{BASE_DIR}/audio/gspeech.out.mp3 -af \"adelay=2000|2000\" -y #{BASE_DIR}/audio/gspeech.left_padded.mp3"
left_pad_cmd_out = %x[#{left_pad_gspeech_cmd}]
left_pad_cmd_exitstatus = $?.exitstatus
puts "Executed left padding: #{left_pad_cmd_exitstatus}"


# https://stackoverflow.com/questions/6239350/how-to-extract-duration-time-from-ffmpeg-output
FFPROBE_CMD = "ffprobe -i FILE_PATH -show_entries format=duration -v quiet -of csv=\"p=0\""
puts "2. finding length of audio files using: #{FFPROBE_CMD}"

file_path_gspeech = "#{BASE_DIR}/audio/gspeech.left_padded.mp3" 
gspeech_cmd = FFPROBE_CMD.sub(/FILE_PATH/,file_path_gspeech)
length_gspeech=%x[#{gspeech_cmd}]
puts "length of gspeech = #{length_gspeech}"

file_path_background="#{BASE_DIR}/audio/background.mp3"
background_cmd=FFPROBE_CMD.sub(/FILE_PATH/, file_path_background)
length_background=%x[#{background_cmd}]
puts "length of background = #{length_background}"

# https://superuser.com/questions/579008/add-1-second-of-silence-to-audio-through-ffmpeg
padding = length_background.to_i - length_gspeech.to_i + 1
puts "3. Padding to be added: #{padding}"

PADDING_CMD = "ffmpeg -i INPUT1 -af \"apad=pad_dur=PAD\" OUTPUT"
padding_cmd_final = PADDING_CMD.sub(/INPUT1/,file_path_gspeech).sub(/PAD/,padding.to_s).sub(/OUTPUT/,"#{BASE_DIR}/audio/gspeech.padded.mp3")
puts "4. Adding padding using: #{padding_cmd_final}"

padding_cmd_out = %x[#{padding_cmd_final}]
padding_cmd_exitstatus = $?.exitstatus
puts "Executed padding: #{padding_cmd_exitstatus}"
