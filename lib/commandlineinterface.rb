require 'pry'
class CommandLineInterface

	def greet
		puts "Welcome to the Sports and Cities Analytics Project!"
		puts "Here you can learn about the MLB, NHL, NFL, and NBA and the cities in which those leagues have teams."
		puts "Would you like to learn about cities or leagues? (cities/leagues)"
		input = get_user_input
		answers = ["cities", "leagues"]
		if !answers.include?(input)
			invalid_input
			greet
		elsif input == "cities"
			list_cities
			puts "Please choose a city to learn more about that cities sports and teams (type the name exactly as you see it)"
			city_input = get_user_input
			until City.find_by(name: city_input.titleize)
				invalid_input
				city_input = get_user_input
			end
				city_questions(city_input)
		else
			list_leagues
			puts "Please choose a league to learn more about that leagues sports and teams (type the name exactly as you see it)"
			league_input = get_user_input
			until League.find_by(name: league_input.upcase)
				invalid_input
				league_input = get_user_input
			end
				league_questions(league_input)
		end
		query_again?
	end

	def get_user_input
		gets.chomp
	end

	def invalid_input
		puts "That input is not valid. Please try again."
	end

	def list_cities
		City.list_cities
	end

	def list_leagues
		League.list_leagues
	end

	def city_questions(city)
		puts "Choose one of the following questions by typing in the number of the question and hitting enter:"
		puts "   1. What leagues are in #{city.titleize}?"
		puts "   2. What teams are in #{city.titleize}?"
		puts "   3. How many professional teams does #{city.titleize} have?"
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
		city_instance = City.find_by(name: city.titleize)
		case question_choice
		when "1"
			city_instance.list_leagues
		when "2"
			city_instance.list_teams
		when "3"
			city_instance.count_teams
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
			puts "Would you like to go to #{league.upcase}'s website? (y/n)"
			input = get_user_input
			if input == "y"
				league_instance.league_website
			end
	end

	def query_again?
		puts "Would you like to do another search? (y/n)"
		input = get_user_input
		if input.downcase == "n"
			exit
		elsif input.downcase == "y"
			greet
		else
			invalid_input
			query_again?
		end
	end

	def run
		cli = CommandLineInterface.new
		cli.greet
	end
end