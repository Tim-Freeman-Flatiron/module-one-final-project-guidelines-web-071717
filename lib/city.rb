class City < ActiveRecord::Base
has_many :city_leagues
has_many :leagues, through: :city_leagues



end