require 'open-uri'
require 'nokogiri'
require 'pry'

def get_page(league)
  Nokogiri::HTML(open("http://www.espn.com/#{league}/teams"))
end

page = get_page("mlb")

league_websites = page.css("a.bi").map do |link|
  link.attribute('href').value
end  


