# require 'linkedin_scraper'
require_relative 'profile'
require_relative 'db_handler'

UNIV_NAMES = ['ncsu', 'north carolina state university','nc state university', 'n.c. state university', 'n.c.s.u']

class Scrape
  def initialize (url_file_path)
    #TODO check if file exists
	@url_file_path = url_file_path
	@db_handler = DBHandler.new()

  end

  def start_throttled_scrape(interrequest_interval_secs)
	File.open(@url_file_path, "r").each_line do |url|
	  puts url
	  profile = Linkedin::Profile.get_profile(url)
	  all_courses = profile.courses
	  p all_courses
	  ncsu_courses = all_courses.select do |courses_at_school|
	    UNIV_NAMES.include? courses_at_school[:school].downcase
	  end
	  ncsu_courses.each do |ncsu_course|
		@db_handler.insert_new_course_for_url(url, ncsu_course[:courses])
	  end
	  puts "###################"
	  return
	end
  end
end

Scrape.new("./results/urls.txt").start_throttled_scrape(10)
