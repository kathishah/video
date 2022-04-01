require 'csv'
require 'stringio'

def extract(full_description)
  #add more keywords here
  keywords = ['hardwood', 'open floor', 'designer', 'ceilings', 'chef', 'pool', 'french', 'granite', 'open space'] 
  expression = keywords.join("|")

  #output
  extracted_description = StringIO.new

  #divide into sentences using period
  sentences = full_description.split('.')
  puts "extract(): sentences = #{sentences.length}"

  #return if there are no sentences
  return extracted_description.string if sentences.length == 1

  #capture the first sentence directly
  extracted_description << sentences[0] << ". "

  for i in 1..(sentences.length - 1) do
    if sentences[i].downcase.match(expression)
      puts "Found match: #{sentences[i]}"
      extracted_description << sentences[i] << ". "
    end
  end

  puts "extract(): captured = #{extracted_description.string}"
  extracted_description.string
end

#main
POS_DESCRIPTION=4
n = 5
IO.foreach(Dir::home + "/dev/video/properties/trulia_dataset.csv") do |line|
  break if n == 0 #do only for n lines
  CSV.parse(line) { |row|
    puts "desc = #{row[POS_DESCRIPTION]}"

    output = self.extract(row[POS_DESCRIPTION])

    puts "output = #{output}"
    puts "========================================="
  }
  n = n - 1
end
