require 'pry'
class CommandLineInterface

	def greet
		greet_statements.each do |statement|
			stars
			puts statement
		end
	end

	def greet_statements
		["Welcome to the Sports and Cities Analytics Project!", "Here you can learn about the MLB, NHL, NFL, and NBA and the cities in which those leagues have teams, and you can even visit their websites!", "You can type 'exit' to quit the program at any time."]
	end

	def valid_input?(input, answer_array)
		answer_array.include?(input)
	end

	def valid_league_choices(league)
		league_questions_array(league).each_index.map do |question|
			(question + 1).to_s
		end << "exit"
	end

	def valid_city_choices(city)
		city_questions_array(city).each_index.map do |question|
			(question + 1).to_s
		end << "exit"
	end

	def stars
		puts Paint["************", :yellow]
	end

	def initial_prompt
		puts "Would you like to learn about cities or leagues? (cities/leagues)"
	end

	def get_user_input
		gets.chomp
	end

	def invalid_input
		puts Paint["That input is not valid. Please try again.", :red, :bright]
	end

	def list_cities
		City.list_cities
	end

	def list_leagues
		League.list_leagues
	end

	def city_questions_array(city)
		["   1. What leagues are in #{city.titleize}?", "   2. What teams are in #{city.titleize}?", "   3. How many professional teams does #{city.titleize} have?"]
	end

	def city_questions(city)
		stars
		puts "Choose one of the following questions by typing in the number of the question and hitting enter:"
		city_questions_array(city).each do |question|
			stars
			puts question
		end
		input = get_user_input
		until valid_input?(input, valid_city_choices(city))
			puts Paint["#{input} is not a valid input. Please try again.", :red, :bright]
			input = get_user_input
		end
		if input == "exit"
			exit
		else
			city_answers(input, city)
		end 
	end

	def league_questions_array(league)
		["   1. What cities have #{league.upcase} teams?", "   2. How many #{league.upcase} teams are there overall?", "   3. What are the names of all of the #{league.upcase} teams?", "   4. How many #{league.upcase} teams are there in your state?", "   5. Which cities have the most #{league.upcase} teams?"]
	end

	def league_questions(league)
		puts "Choose one of the following questions by typing in the number of the question and hitting enter:"
		league_questions_array(league).each do |question|
			stars
			puts question
		end
		input = get_user_input
		until valid_input?(input, valid_league_choices(league))
			puts Paint["#{input} is not a valid input. Please try again.", :red, :bright]
			input = get_user_input
		end
		if input == "exit"
			exit
		else
			league_answers(input, league)
		end 
	end

	def city_answers(question_choice, city)
		city_instance = City.find_by(name: city.titleize)
		case question_choice
		when "1"
			stars
			city_instance.list_leagues
		when "2"
			stars
			city_instance.list_teams
		when "3"
			stars
			city_instance.count_teams
		end
		stars
		input = do_you_want_directions?(city)
		until valid_input?(input, ["y","n","exit"])
			puts Paint["#{input} is not a valid input. Please try again.", :red, :bright]
			input = get_user_input
		end
		case input
		when "y"
			give_directions_to_city(city)
		when "exit"
			exit
		end
	end

	def league_answers(question_choice, league)
		league_instance = League.find_by(name: league.upcase)
		case question_choice
		when "1"
			stars
			league_instance.what_cities
		when "2"
			stars
			league_instance.count_teams
		when "3"
			stars
			league_instance.list_teams
			stars
			prompt_to_go_to_team_website
			stars
			prompt_to_search_for_tickets
		when "4"
			puts "What state do you live in? (type out the full name)"
			stars
			input = get_user_input
			stars
			league_instance.number_of_teams_in_state(input)
		when "5"
			stars
			league_instance.cities_with_most_teams
		end
			stars
			puts "Would you like to go to the #{league.upcase}'s website? (y/n)"
			input = get_user_input
			if input == "y"
				league_instance.league_website
			elsif input == "exit"
				exit
			end
			stars
			puts "Would you like to see the #{league.upcase}'s current standings? (y/n)"
			input = get_user_input
			if input == "y"
				league_instance.display_league_standings
			elsif input == "exit"
				exit
			end
	end

	def prompt_city_choice
	puts "Please choose a city to learn more about that cities sports and teams (type the name exactly as you see it)"
	end

	def prompt_to_go_to_team_website
		input = prompt_if_wants_team_website
			until valid_input?(input, ["y","n","exit"])
				invalid_input
				input = get_user_input
			end
			case input
			when "y"
				team = prompt_team_name_for_website
				until Team.find_by(name: team.titleize)
					invalid_input
					team = prompt_team_name_for_website
				end
				team_instance = Team.find_by(name: team.titleize)
				team_instance.launch_team_website
			when "exit"
				exit
			end
	end

	def prompt_choose_league
		puts "Please choose a league to learn more about that leagues sports and teams (type the name exactly as you see it)"
	end

	def query_again?
		stars
		puts "Would you like to do another search? (y/n)"
		input = get_user_input
		if input.downcase == "n" || input.downcase == "exit"
			exit
		elsif input.downcase == "y"
			self.run
		else
			invalid_input
			query_again?
		end
	end

	def user_chooses_cities
		stars
		list_cities
		stars
		prompt_city_choice
		city_input = get_user_input
		if city_input == "exit"
			exit
		end
		until City.find_by(name: city_input.titleize)
			invalid_input
			city_input = get_user_input
		end
			city_questions(city_input)
	end

	def prompt_if_wants_team_website
		puts "Would you like to go to a team's website? (y/n)"
		get_user_input
	end

	def prompt_team_name_for_website
		puts "Which team's site would you like to visit? (type the team name exactly as you see it here)"
		get_user_input
	end

	def user_chooses_leagues
		stars
		list_leagues
		stars
		prompt_choose_league
		league_input = get_user_input
		if league_input == "exit"
			exit
		end
		until League.find_by(name: league_input.upcase)
			invalid_input
			league_input = get_user_input
		end
			league_questions(league_input)
	end

	def prompt_to_search_for_tickets
		input = want_to_search_for_tickets?
		until valid_input?(input, ["y","n","exit"])
			invalid_input
			input = get_user_input
		end
		case input
		when "y"
		stars
		team = prompt_which_team_to_search
			until Team.find_by(name: team.titleize)
				invalid_input
				team = prompt_team_name_for_website
			end
			team_instance = Team.find_by(name: team.titleize)
			team_instance.search_for_tickets
		when "exit"
				exit
		end
		
	end

	def want_to_search_for_tickets?
		puts "Do you want to search for tickets for a team?"
		get_user_input
	end

	def prompt_which_team_to_search
		puts "Which team would you like to search (type the team name exactly as you see it here)"
		get_user_input
	end

	def do_you_want_directions?(city)
		puts "Would you like to directions to #{city.titleize} so that you can catch a game? (y/n)"
		get_user_input
	end

	def give_directions_to_city(city)
		puts "What is the ZIP code of your current location?"
		input = get_user_input
		until valid_zip_code(input)
			invalid_input
			input = get_user_input
		end
		state = City.find_by(name: city.titleize).state
		Launchy.open("https://www.google.com/maps/dir/#{input}/#{city}+#{state}")
	end

	def valid_zip_code(input)
		numbers = ["1","2","3","4","5","6","7","8","9","0"]
		input.split.each do |num|
			numbers.include?(num)
		end
	end

	def run
			stars
			initial_prompt
			stars
			input = get_user_input
			if !valid_input?(input, ["cities", "leagues", "exit"])
				invalid_input
				run
			else 
				case input
				when "cities"
					user_chooses_cities
				when "leagues"
					user_chooses_leagues
				when "exit"
					exit
				end
			end
			query_again?
	end
end