require 'uri'
require 'open-uri'
require "json"
require "time"

BASE_URL = "https://www.googleapis.com/customsearch/v1?key=<YOUR_API_KEY_HERE>&cx=001998005080899164904:zhuvw5wn6hs&q="

class Search 
  def initialize (search_query)
    #TODO convert to proper query
    search_query = search_query.gsub(/ /, '+')
	@url = BASE_URL + search_query
  end

  def fetch_hcards_from_query(index = 0)
	paging_url = @url
    paging_url = @url + "&start=#{index}" if index !=  0
	#TODO find some way to handle parsing and url open errors besides just ignoring exception
	response = ""
	begin
	  response = open(paging_url).read
	rescue
	  puts "#{Time.now} Exception occured in open_http() #{$!}"
	end

	parsed_resp = JSON.parse(response)
	if !parsed_resp['error'].nil?
      puts "Stopping at #{url} due to error!"
	  puts parsed_resp
	else
	  File.open("./results/urls.txt", 'a') do |url_file|
	    parsed_resp['items'].each do |search_card|
		  puts search_card['title']
		  url_file.puts search_card['link'] 
		end
	  end
	 fetch_hcards_from_query(parsed_resp['queries']['nextPage'][0]['startIndex']) if !parsed_resp['queries']['nextPage'].nil?
	end
  end
end

Search.new("ncsu computer science india").fetch_hcards_from_query();
