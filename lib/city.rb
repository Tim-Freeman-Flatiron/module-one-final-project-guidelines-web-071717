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
		self.leagues.each do |league|
			puts league.name
		end
	end

	def list_teams
		self.teams.each do |team|
			puts team.name
		end
	end

	def count_teams
		puts self.teams.count
	end


end