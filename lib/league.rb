require 'pry'
class League < ActiveRecord::Base
	has_many :teams
	has_many :city_leagues
	has_many :cities, through: :city_leagues

	def self.list_leagues
		self.all.each do |league|
			puts league.name
		end
	end

	def count_cities
		self.cities.uniq.length
	end

	def what_cities
		self.cities.uniq.each do |city|
			puts city.name
		end
	end

	def count_teams
		puts self.teams.uniq.length
	end

	def list_teams
		self.teams.each do |team|
			puts team.name
		end
	end

	def array_of_team_names
		self.teams.map {|team| team.name}
	end

	def number_of_teams_in_state(state)
		num = self.cities.select do |city|
			city.state == state
		end.length
		puts num
	end

	def league_website
		url = "http://www.espn.com/#{self.name.downcase}"
		Launchy.open(url)
	end

	def cities_with_most_teams
		city_count_hash = self.cities.group(:name).order('count_id DESC').limit(3).count(:id)
		city_count_hash.each do |city, count|
			puts "#{city} has #{count} team(s)."
		end
	end

end

