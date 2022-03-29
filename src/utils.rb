module Utils
  def self.add_text(input_video_file_path, input_text_file_path, pos_x, pos_y, output_file_path, font_file_path = Dir::home + "/dev/video/common/font.ttf", font_color = "white", font_size = 36, options = {})
    cmd = "ffmpeg -i #{input_video_file_path} -vf \"drawtext=fontfile=#{font_file_path}:textfile=#{input_text_file_path}:fontcolor=#{font_color}:fontsize=#{font_size}:x=#{pos_x}:y=#{pos_y}\" -codec:a copy #{output_file_path}"
    puts "Adding text\n\t#{cmd}"
    return self.exec(cmd, options)
  end #self.add_text

  def self.exec(cmd, options = {})
    unless options[:noop]
      cmd_output = %x[#{cmd}]
      cmd_exitstatus = $?.exitstatus
      puts "\texit status: #{cmd_exitstatus}"
      return cmd_exitstatus
    else
      puts "\tNOOP"
    end
  end #self.exec
end

