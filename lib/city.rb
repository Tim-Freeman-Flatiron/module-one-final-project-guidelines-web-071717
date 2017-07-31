class City < ActiveRecord::Base
has_many :city_leagues
has_many :leagues, through: :city_leagues
has_many :teams, through: :leagues

def count_leagues
	self.leagues.uniq.length
end


end