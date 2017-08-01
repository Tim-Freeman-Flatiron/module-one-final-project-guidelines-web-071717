class Team < ActiveRecord::Base
belongs_to :city
belongs_to :league

	def get_team_website
		league_websites = self.league.get_league_team_websites
		team_website = league_websites.find do |website|
			if self.name.include?(" ")
				team_name = self.name.downcase.split(" ").join('-')
			else
				team_name = self.name.downcase
			end
			website.include?(team_name)
		end
	end

	def launch_team_website
		website = get_team_website
		Launchy.open(website)
	end


end