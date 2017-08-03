require 'pry'
class City < ActiveRecord::Base
has_many :city_leagues
has_many :leagues, through: :city_leagues
has_many :teams

	def self.list_cities
		self.all.each do |city|
			puts city.name
		end
	end

	def count_leagues
		self.leagues.uniq.length
	end

	def list_leagues
		puts Paint["#{self.name} is home to team(s) from the ", Paint.random]
		self.leagues.uniq.each do |league|
			puts league.name
		end
	end

	def list_teams
		self.teams.each do |team|
			puts Paint["#{self.name} is home to the #{team.name} of the #{team.league.name}.", Paint.random]
		end
	end

	def count_teams
		puts Paint["#{self.name.titleize} has #{self.teams.count} professional sports team(s).", Paint.random]
	end

	def give_directions_to_city(zipcode)
		Launchy.open("https://www.google.com/maps/dir/#{zipcode}/#{self.name}+#{self.state}")
	end

	def self.city_with_most_teams_overall
		city = City.joins(:teams).group('cities.id').order('count(teams.city_id) DESC').limit(1)[0]
		puts Paint["#{city.name} has the most professional sports teams with a total of #{city.teams.count} teams.", Paint.random]
	end

end