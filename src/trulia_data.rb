require 'csv'
require 'stringio'

POS_DESCRIPTION=4
keywords = ['hardwood', 'open floor', 'designer', 'ceilings', 'chef', 'pool', 'french', 'granite', 'open space']
expression = keywords.join("|")
n = 5
IO.foreach(Dir::home + "/dev/video/properties/trulia_dataset.csv") do |line|
  if n > 0
    CSV.parse(line) { |row|
      extracted_description = StringIO.new
      puts "desc = #{row[POS_DESCRIPTION]}"
      next if n == 5

      sentences = row[POS_DESCRIPTION].split('.')
      puts "sentences = #{sentences.length}"

      extracted_description << sentences[0] << ". "

      for i in 1..(sentences.length - 1) do
        if sentences[i].downcase.match(expression)
          puts "Found match: #{sentences[i]}"
          extracted_description << sentences[i] << ". "
        end
      end

      puts "extracted = #{extracted_description.string}"
      puts "========================================="
    }
  end
  n = n - 1
end
