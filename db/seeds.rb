
file = './data.csv'
stats_file = './team_stats.csv'

CSVParser::Adapter.new.fill_table_from_csv(file)
CSVParser::Adapter.new.fill_teams_stats(stats_file)

# def fill_table_from_csv(file)
# 	League.delete_all
# 	Team.delete_all
# 	City.delete_all
# 	CityLeague.delete_all

# 	CSV.foreach(file) do |row|

# 		new_city = City.find_or_create_by(name: row[1]) do |city|
# 			city.state = row[2]
# 		end

# 		new_league = League.find_or_create_by(name: row[6])

# 		new_team = Team.create(name: row[0], city_id: new_city.id, league_id: new_league.id)
	
# 		CityLeague.create(city_id: new_city.id, league_id: new_league.id)

# 	end

# city_first_row = City.find_by(name: "City")
# league_first_row = League.find_by(name: "League")
# team_first_row = Team.find_by(name: "Team")

# city_first_row.destroy
# league_first_row.destroy
# team_first_row.destroy

# end
