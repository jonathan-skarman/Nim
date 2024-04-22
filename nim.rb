require_relative 'functions.rb'

def pvp()
	loop do
		sticks = rand(4..14)
		turn = rand(1..2)
		puts "There are #{sticks} sticks in the pile"

		while (sticks != 0)
			if turn == 2
				turn = 1
			else
				turn = 2
			end

			puts "Player #{turn} begins"
			puts "You can take between 1 and 3 sticks"
			puts "How many do you take"
				input = gets.to_i
				while !(verify(input))
					puts "Invalid input, please input a number between 1 and 3"
					input = gets.to_i
				end
				sticks -= input
			puts "There are now #{sticks} sticks left"
		end

		puts "Player #{turn} loses"
		puts "Do you want to play again? (y/n)"
		answer = gets.chomp.downcase
		break unless answer == "y"
	end
end

def botEasy()
	loop do
		sticks = rand(4..14)
		turn = rand(1..2)
		puts "There are #{sticks} sticks in the pile"

		while (sticks != 0)
			if turn == 2
				turn = 1
			else
				turn = 2
			end

			if turn == 1
				puts "You can take between 1 and 3 sticks"
				puts "How many do you take"
					input = gets.to_i
					while !(verify(input))
						puts "Invalid input, please input a number between 1 and 3"
					end
					sticks -= input
				puts "There are now #{sticks} sticks left"
			else
				if sticks > 3
					bot = rand(1..3)
				else
					bot = rand(1..sticks)
				end
				sticks -= bot

				puts "The bot takes #{bot} sticks"
				puts "There are now #{sticks} sticks left in the pile"
			end
		end

		if turn == 1
			puts "You lose"
		else
			puts "You win"
		end

		puts "Do you want to play again? (y/n)"
		answer = gets.chomp.downcase
		break unless answer == "y"
	end
end

botEasy()

def botHard()
end



def runner()
	puts "Pvp or against a bot?"
	mode = gets.chomp.downcase
	if mode == "pvp"
		pvp()

	elsif mode == "bot"
		puts "Easy or hard?"
		difficulty = gets.chomp.downcase
		if difficulty == "easy"
			botEasy()
		elsif difficulty == "hard"
			botHard()
		end
	end
end

#runner()
