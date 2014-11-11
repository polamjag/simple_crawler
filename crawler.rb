#coding: utf-8
require 'json'
require 'nokogiri'
require 'sqlite3'
require 'open-uri'
require './googleapi_password'

class Crawler
	def initialize(name, dir)
		@name = name
		@index = 1
		@num = 10
		@dir = "#{dir}/"
		@url = "https://www.googleapis.com/customsearch/v1?key=#{$api_key}&cx=#{$cx}&q=#{@name}&num=#{@num}&start=#{@index}&alt=json"
		Dir.mkdir(@dir)
	end
	def export(text)
		open("#{@dir}#{@name}_#{@index}.json", "w"){|output|
			output.print(text.read)
		}
	end
	def crawl
		while @index <= 91
			url_encode = URI.encode(@url)
			open(url_encode, 'r'){|text|
				export(text)
			}
			@index += 10
		end
	end
end

class Parser
	def initialize(name, dir)
		@name = name
		@dir = dir
	end
	def db_write(list)
		db = SQLite3::Database.new("#{@name}.db")
		sql = <<-SQL
		create table Person (
			id integer primary key autoincrement,
			title text,
			url text
			);
		SQL
		db.execute(sql)
		list.each{|title, url|
			db.execute("insert into url(title, url) values(?, ?)", title, url)
		}
	end
	def scribe
		list = Hash.new
		open(@dir, "r"){|text|
			parsed_text = JSON.parse(text.read)
			parsed_text['items'].each{|item|
				list.store(item['title'], item['link'])
			}
		}
		db_write(list)
	end
	def dir_open
		Dir.open(@dir).each{|file|
			if file =~ /^\.+/
				next
			end
			scribe("#{@dir}#{file}")
		}
	end
end


#ARGV = {:0=>keyword, 1:=>directory_name}
Crawl = Crawler.new(ARGV[0], ARGV[1])
Crawl.crawl
Parse = Parser.new(ARGV[0], ARGV[1])
Parse.dir_open
