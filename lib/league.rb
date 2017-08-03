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
		puts Paint["There are #{self.teams.uniq.length} #{self.name} teams.", Paint.random]
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
			city.state.downcase == state.downcase
		end.length
		puts Paint["#{state.titleize} has #{num} #{self.name} team(s).", Paint.random]
	end

	def league_website
		url = "http://www.espn.com/#{self.name.downcase}"
		Launchy.open(url)
	end

	def cities_with_most_teams
		city_count_hash = self.cities.group(:name).order('count_id DESC').limit(3).count(:id)
		city_count_hash.each do |city, count|
			puts Paint["#{city} has #{count} team(s).", Paint.random]
		end
	end

	def display_league_standings
		league = self.name.downcase
		url = "http://www.espn.com/#{league}/standings"
		Launchy.open(url)
	end

	def normalize_name_for_url
		self.name.downcase
	end

	def get_league_team_websites
		page = Nokogiri::HTML(open("http://www.espn.com/#{normalize_name_for_url}/teams"))
		websites = page.css("a.bi").map do |link|
			link.attribute('href').value
		end
	end

	def get_array_of_league_teams
		self.teams
	end

	def team_with_most_championships
		team = self.teams.select("name", "championships").order(championships: :desc).limit(1)[0]
		puts Paint["The #{team.name} have the most with #{team.championships} championships.", Paint.random]
	end

	def team_with_most_playoffs
		team = self.teams.select("name", "playoffs").order(playoffs: :desc).limit(1)[0]
		puts Paint["The #{team.name} have the most with #{team.playoffs} playoff appearances.", Paint.random]
	end

	def team_with_most_wins
		team = self.teams.select("name", "wins").order(wins: :desc).limit(1)[0]
		puts Paint["The #{team.name} have the most with #{team.wins} wins.", Paint.random]
	end

	def team_with_most_losses
	team = self.teams.select("name", "losses").order(losses: :desc).limit(1)[0]
	puts Paint["The #{team.name} have the most with #{team.losses} losses.", Paint.random]
	end

	def average_team_wins
		puts Paint["The average team in the #{self.name} has #{self.teams.average("wins").to_i} wins.", Paint.random]
	end

	def average_playoffs
		puts Paint["The average team in the #{self.name} has #{self.teams.average("playoffs").to_i} playoff appearances.", Paint.random]
	end

end

