class League < ActiveRecord::Base
	has_many :teams
	has_many :city_leagues
	has_many :cities, through: :city_leagues

	def count_cities
		self.cities.uniq.length
	end

end