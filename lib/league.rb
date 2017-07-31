class League < ActiveRecord::Base
has_many :city_leagues
has_many :cities, through: :city_leagues



end