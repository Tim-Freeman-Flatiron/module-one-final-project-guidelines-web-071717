require 'pry'
class CommandLineInterface

	def greet
		puts "Welcome to the Sports and Cities Analytics Project!"
		puts "Here you can learn about the MLB, NHL, NFL, and NBA and the cities in which those leagues have teams."
		puts "Would you like to learn about cities or leagues? (cities/leagues)"
		input = get_user_input
		answers = ["cities", "leagues"]
		if !answers.include?(input)
			puts "#{input} is not a valid input. Please try again."
			greet
		elsif input == "cities"
			City.list_cities
			puts "Please choose a city to learn more about that cities sports and teams (type the name exactly as you see it)"
			city_input = get_user_input
			city_questions(city_input)
		else
			League.list_leagues
			puts "Please choose a league to learn more about that leagues sports and teams (type the name exactly as you see it)"
			league_input = get_user_input
			league_questions(league_input)
		end
	end

	def get_user_input
		gets.chomp
	end

	def city_questions(city)
		puts "Choose one of the following questions by typing in the number of the question and hitting enter:"
		puts "   1. What leagues are in #{city}?"
		puts "   2. What teams are in #{city}?"
		puts "   3. How many professional teams does #{city} have?"
		input = get_user_input
		questions = ["1", "2", "3"]
		if !questions.include?(input)
			puts "#{input} is not a valid input. Please try again."
			input = city_questions(city)
		else
			city_answers(input, city)
		end 
	end

	def league_questions(league)
		puts "Choose one of the following questions by typing in the number of the question and hitting enter:"
		puts "   1. What cities have #{league.upcase} teams?"
		puts "   2. How many #{league.upcase} teams are there overall?"
		puts "   3. What are the names of all of the #{league.upcase} teams?"
		puts "   4. How many #{league.upcase} teams are there in your state?"
		input = get_user_input
		questions = ["1", "2", "3", "4"]
		if !questions.include?(input)
			puts "#{input} is not a valid input. Please try again."
			input = league_questions(league)
		else
			league_answers(input, league)
		end 
	end

	def city_answers(question_choice, city)
		league_instance = City.find_by(name: city.titleize)
		case question_choice
		when "1"
			league_instance.list_leagues
		when "2"
			league_instance.list_teams
		when "3"
			league_instance.count_teams
		end
	end

	def league_answers(question_choice, league)
		league_instance = League.find_by(name: league.upcase)
		case question_choice
		when "1"
			league_instance.what_cities
		when "2"
			league_instance.count_teams
		when "3"
			league_instance.list_teams
		when "4"
			puts "What state do you live in? (type out the full name)"
			league_instance.number_of_teams_in_state(get_user_input)
		end

	end

	def run
		cli = CommandLineInterface.new
		cli.greet
	end
end