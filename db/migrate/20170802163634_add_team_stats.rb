class AddTeamStats < ActiveRecord::Migration[5.0]
  def change
  	add_column :teams, :games, :integer
  	add_column :teams, :wins, :integer
  	add_column :teams, :losses, :integer
  	add_column :teams, :winning_percentage, :float
  	add_column :teams, :playoffs, :integer
  	add_column :teams, :championships, :integer
  end
end
