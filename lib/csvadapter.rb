module CSVParser
	require 'CSV'
	require 'pry'

	class Adapter
		
		file = '../data.csv'

		def fill_table_from_csv(file)
			League.delete_all
			Team.delete_all
			City.delete_all
			CityLeague.delete_all
		
			CSV.foreach(file) do |row|

				new_city = City.find_or_create_by(name: row[1]) do |city|
					city.state = row[2]
				end

				new_league = League.find_or_create_by(name: row[6])

				new_team = Team.create(name: row[0], city_id: new_city.id, league_id: new_league.id)
			
				CityLeague.create(city_id: new_city.id, league_id: new_league.id)
	  
	  	end

		city_first_row = City.find_by(name: "City")
		league_first_row = League.find_by(name: "League")
		team_first_row = Team.find_by(name: "Team")
		hornets = Team.find_by(name: "Bobcats")
		hornets.update(name: "Hornets")

		city_first_row.destroy
		league_first_row.destroy
		team_first_row.destroy

		end

		stats_file = '../team_stats.csv'

		def fill_teams_stats(stats_file)
			
			CSV.foreach(stats_file) do |row|
				league = League.find_by(name: row[1])
				league_teams = Team.all.select {|team| team.league_id == league.id}
				team = league_teams.select {|team| team.name == row[0]}[0]
				team.update(games: row[2], wins: row[3], losses: row[4], winning_percentage: row[5], playoffs: row[6], championships: row[7])
			end
		end
	end
end