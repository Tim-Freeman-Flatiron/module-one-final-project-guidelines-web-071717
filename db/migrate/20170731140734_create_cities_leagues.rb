class CreateCitiesLeagues < ActiveRecord::Migration[5.0]
  def change
  	create_table :city_leagues do |t|
  		t.integer :city_id
  		t.integer :league_id
  	end
  end
end
