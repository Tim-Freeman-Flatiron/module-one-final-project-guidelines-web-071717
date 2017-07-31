require 'bundler'
Bundler.require
require_relative '../lib/city.rb'
require_relative '../lib/city_league.rb'
require_relative '../lib/league.rb'
require_relative '../lib/commandlineinterface.rb'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'

