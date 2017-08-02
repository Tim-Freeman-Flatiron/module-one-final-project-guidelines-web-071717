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
		puts "#{self.name} is home to team(s) from the "
		self.leagues.uniq.each do |league|
			puts league.name
		end
	end

	def list_teams
		
		self.teams.each do |team|
			puts "#{self.name} is home to the #{team.name} of the #{team.league.name}."
		end
	end

	def count_teams
		puts "#{self.name.titleize} has #{self.teams.count} professional sports team(s)."
	end
end