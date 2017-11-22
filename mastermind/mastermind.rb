class Game
	attr_reader :turns, :code
	def initialize
		@@colour_array = [:red, :yellow, :green, :blue, :purple, :black]
		@code = []
		@turns = 12
	end
	
	def random_code
		4.times do 
			@code.push(@@colour_array[rand(6)])
		end
		@code
	end
	
	def guess(guess_array)
		feedback = {}
		correct_guess = 0
		correct_colour = 0
		unique = guess_array.uniq
		
		unique.each do |colour|
			if @code.include?(colour)
				difference = guess_array.count(colour) - @code.count(colour)
				if difference > 0
					correct_colour -= difference
				end
			end
		end
		
		guess_array.each_with_index do |colour, index|
			if @code.include?(colour)
				if @code[index] == colour
					correct_guess += 1
				else
					correct_colour += 1
				end
			end
		end
		
		@turns -= 1
		feedback = {"Correct positions": correct_guess, "Correct colours": correct_colour}
	end
	
	def game_over?(guess_array)
		if @turns > 0 && guess_array == @code
			puts "Code guessed correctly, you win!"
			true
		elsif @turns == 0 && guess_array == @code
			puts "Your last guess was correct, you win!"
			true
		elsif @turns == 0 && guess_array != @code
			puts "You're out of guesses, you lose!"
			true
		else
			false
		end
		
	end
	
	def ai_logic
	end
	
	
end

quit = false

until quit
	puts	""
	puts "Welcome to Mastermind"
	puts	""
	puts "You will have 12 tries to guess the hidden code."
	puts "After each guess you will be given feedback on how good your guess was."
	puts	""
	puts "The colours to choose from are:"
	puts "Red,	Yellow,	Green,	Blue,	Purple,	Black"
	
	game = Game.new
	game.random_code
	user_guess = []
	until game.game_over?(user_guess)
		user_guess = []
		(1..4).each do |i|
			puts "Colour #{i}:"
			user_colour = gets.chomp.downcase.to_sym
			user_guess.push(user_colour)
		end
		puts "Your guess #{user_guess}"
		puts game.guess(user_guess)
		unless game.turns == 0 || game.code == user_guess
			puts "Guesses left: #{game.turns}"
		end
		puts
	end
	puts "Do you want to play again?"
	user_input = gets.chomp.downcase
	unless user_input == "yes" || user_input == "y" || user_input == "1"
		quit = true
	end
	
	
end