require 'json'
require 'yelp/fusion'

# https://github.com/erikgrueter1/yelp-fusion

#initialize client
yelp_credentials = JSON.parse(IO.read(Dir::home + "/dev/video/conf/yelp.cred"))
puts "Initializing..."
client = Yelp::Fusion::Client.new(yelp_credentials["apiKey"])
puts "Client initialized"

#search
search_city = "San Jose"
search_term = "mexican food"
puts "Searching for \"#{search_term}\" in \"#{search_city}\""
response = client.search("#{search_city}", { term: "#{search_term}" })
puts "Found #{response.total} listings. Response contains: #{response.businesses.length} businesses" 

#get the first N
N=10
unless (response.businesses.length >= N)
  puts "Didn't find #{N} businesses in the response. Bye...."
  exit 0
else
  puts "Fetching the first #{N}"
end

for i in 0..N do
  fetch_id = response.businesses[i].id
  puts "Fetching for \"#{fetch_id}\""
  business_details = client.business(fetch_id)
  business = business_details.business
  
  #1. images
  photos = business.photos #only 3 photos
  # more photos: https://www.yelp.com/biz_photos/#{fetch_id}

  #2. reviews
  overall_rating = business.rating
  review_count = business.review_count

  reviews = client.review(fetch_id).reviews
  # every review has the username: review[i].name and description: review[i].text
end
