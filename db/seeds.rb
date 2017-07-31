require 'CSV'
require 'pry'

def fill_table_from_csv(csv)
	League.delete_all
	Team.delete_all
	City.delete_all
	
	CSV.foreach(csv) do |row|

		new_city = City.find_or_create_by(name: row[1]) do |city|
			city.state = row[2]
		end

		new_league = League.find_or_create_by(name: row[6])

		new_team = Team.find_or_create_by(name: row[0]) do |team|
		 team.city_id = new_city.id
		 team.league_id = new_league.id
		end
	
		CityLeague.create(city_id: new_city.id, league_id: new_league.id)
  
  end

	city_first_row = City.find_by(name: "City")
	league_first_row = League.find_by(name: "League")

	city_first_row.destroy
	league_first_row.destroy

end

fill_table_from_csv('./league_data.csv')