class Team < ActiveRecord::Base
belongs_to :city
belongs_to :league

	def get_team_website
		league_websites = self.league.get_league_team_websites
		team_website = league_websites.find do |website|
			team_name = normalize_name_for_url
			website.include?(team_name)
		end
	end

	def normalize_name_for_url
		if self.name.include?(" ")
				team_name = self.name.downcase.split(" ").join('-')
			else
				team_name = self.name.downcase
		end
	end		

	def normalize_league_name_for_url
		self.league.name.downcase
	end

	def launch_team_website
		website = get_team_website
		Launchy.open(website)
	end

	def search_for_tickets
		team_name = self.name.downcase.split(" ").join("%20")
		league_name = normalize_league_name_for_url
		website = "https://www.stubhub.com/find/s/?q=#{league_name}%20#{team_name}"
		Launchy.open(website)
	end

	def self.team_with_most_championships_overall
		team = Team.select("name", "championships").order(championships: :desc).limit(1)[0]

		puts "The #{team.name} have the most championships of any professional sports teams with #{team.championships} championships."
	end


end