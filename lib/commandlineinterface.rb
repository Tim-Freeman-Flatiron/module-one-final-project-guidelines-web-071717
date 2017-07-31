class CommandLineInterface

	def greet
		puts "Welcome to the Sports and Cities Analytics Project!"
	end

	# def city_or_sport?
	# 	puts "Would you like to know about a city or a sport? (city/sport)"
	# 	input = gets.chomp
	# 	if input.downcase != "city" || input.downcase != "sport"
	# 		puts "#{input} is not a valid input. Please try again"
	# 		city_or_sport?
	# 	end
	# end

	# def which_sport
	# 	puts "Which sports league are you interested in learning more about?"
	# 	puts "NBA, NHL, MLB, or NFL?"
	# 	input = gets.chomp.upcase
	# end

	# def sport_questions(league)
	# 	puts "Ok great! #{league} it is!"
	# 	puts "Here the questions you can ask:"
	# 	puts "1. How many cities have #{league} teams?"
	# 	puts "2. How many #{league} teams are there overall?"
	# 	puts "Please type the number of your question and hit enter."
	# 	gets.chomp
	# end

	# def city_questions(city)
	# 	puts "Ok great! #{city} it is!"
	# 	puts "Here the questions you can ask:"
	# 	puts "1. What professional sports are in #{city}?"
	# 	puts "2. "

	# end

	# def which_city
	# 	puts "Choose a city from the list below:"
	# 	input = gets.chomp.downcase
	# end

	# def list_cities(league)
		
	# end

	# def run
	# 	greet
	# 	city_sport = city_or_sport?
	# 	if city_sport == "city"
	# 		input = which_sport
	# 		city_questions(input)
	# 	else
	# 		input = which_city
	# 		sport_questions(input)
	# 	end
	# end

end