#!/usr/bin/ruby

require 'sqlite3'

DB_NAME = 'li.db'

class DBHandler
  def initialize
    @db = SQLite3::Database.open "li.db"
	@db.execute "CREATE TABLE IF NOT EXISTS profiles(Id INTEGER PRIMARY KEY, 
	        profile_url TEXT, course TEXT)"
    puts "Db #{DB_NAME} initialized"
  end
  
  def insert_new_course_for_url(url, courses)
    courses.each do |course|
      query = 'INSERT INTO profiles(profile_url, course) VALUES ("' + url + '", "' + course + '")'
	  execute_insert_query(query)
	end
  end

  def close
    db.close if db
  end

  private

  def execute_insert_query(query)
    puts 'DBHandler::execute_insert_query() about  to execute ' + query
    begin
	  @db.execute query
	rescue SQLite3::Exception => e 
	  puts "Exception occurred"
	  puts e
	end
  end

end
