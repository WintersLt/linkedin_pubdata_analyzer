require 'linkedin_scraper'

class Scrape
  def initialize (url_file_path)
    #TODO check if file exists
	@url_file_path = url_file_path
  end

  def start_throttled_scrape(interrequest_interval_secs)
	File.open(@url_file_path, "r").each_line do |url|
	  puts url
	  profile = Linkedin::Profile.get_profile(url)
	  p profile.courses
	  puts "###################"
	  return
	end
  end
end

Scrape.new("./results/urls.txt").start_throttled_scrape(10)
