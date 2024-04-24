require_relative 'functions.rb'

def pvp()
	puts ""
	puts "Player 1, say your name:"
	player1_name = gets.chomp
	puts "Player 2 say your name:"
	player2_name = gets.chomp
	loop do

		sticks = rand(4..14)
		turn = rand(1..2)
		puts ""
		puts "There are #{sticks} sticks in the pile"

		while (sticks != 0)
			if turn == 2
				turn = 1
			else
				turn = 2
			end
      current_player_name = (turn == 1) ? player1_name : player2_name

			puts "#{current_player_name}'s turn"

			if sticks < 3
				puts "You can take between 1 and #{sticks} sticks"
				puts "How many do you take"
				input = gets.to_i
				while (!(verify(input)) or (input > sticks))
					if input == "konami".to_i  # Check for the Easter egg input
						puts "You entered the Konami Code! You've unlocked a secret message!"
						puts "Up, up, down, down, left, right, left, right, B, A, Start!"
						puts "╭━━━┳━━━┳━╮╭━╮"
						puts "┃╭━━┫╭━╮┃┃╰╯┃┃"
						puts "┃╰━━┫╰━╯┃╭╮╭╮┃"
						puts "┃╭━━┫╭╮╭┫┃┃┃┃┃"
						puts "┃╰━━┫┃┃╰┫┃┃┃┃┃"
						puts "╰━━━┻╯╰━┻╯╰╯╰╯"
					end

					puts "Invalid input, please input a number between 1 and #{sticks}"
					input = gets.to_i
				end
			else
				puts "You can take between 1 and 3 sticks"
				puts "How many do you take"
				input = gets.to_i
				while !(verify(input))
					puts "Invalid input, please input a number between 1 and 3"
					input = gets.to_i
				end
			end

			sticks -= input

			puts ""
			puts "There are now #{sticks} sticks left"
		end

		puts "#{current_player_name} loses"
		puts "Do you want to play again? (y/n)"
		answer = gets.chomp.downcase
		break unless answer == "y"
	end
end

def pvp2d
	puts ""
	puts "Player 1, enter your name:"
	player1_name = gets.chomp
	puts "Player 2, enter your name:"
	player2_name = gets.chomp
	puts "How many piles"
	max = gets.chomp.to_i
	loop do

		sticks = Array.new(0)
		i = 0
		while sticks.length < max
			sticks.append(rand(1..14))
			i += 1
		end

		turn = rand(1..2)
		puts ""
		puts "The piles are #{sticks}"

		while #alla inte är tomma
			if turn == 2
				turn = 1
			else
				turn = 2
			end
      current_player_name = (turn == 1) ? player1_name : player2_name

			puts "#{current_player_name}'s turn"

			puts "what pile do you want to draw from" #ERRORHANTERING fel input och tom hög
			pile = gets.chomp.to_i - 1
			while (!(verify_pile(pile, max)))


			if sticks[pile] < 3
				puts "You can take between 1 and #{sticks[pile]} sticks"
				puts "How many do you take"
				input = gets.to_i
				while (!(verify(input)) or (input > sticks[pile]))
					puts "Invalid input, please input a number between 1 and #{sticks[pile]}"
					input = gets.to_i
				end
			else
				puts "You can take between 1 and 3 sticks"
				puts "How many do you take"
				input = gets.to_i
				while !(verify(input))
					puts "Invalid input, please input a number between 1 and 3"
					input = gets.to_i
				end
			end
			sticks[pile] -= input

			puts ""
			puts "The piles are now #{sticks}"
		end

		puts "#{current_player_name} loses"
		puts "Do you want to play again? (y/n)"
		answer = gets.chomp.downcase
		break unless answer == "y"
	end
end

def bot(input)
	loop do
		sticks = rand(4..14)
		turn = rand(1..2)
		puts "There are #{sticks} sticks in the pile"
		puts ""

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
				puts ""
			else
				if input == "easy"
					bot = botEasy(sticks)
				elsif input == "hard"
					bot = botHard(sticks)
				else
					raise "no difficulty selected"
				end
				sticks -= bot

				puts "The bot takes #{bot} sticks"
				puts "There are now #{sticks} sticks left in the pile"
				puts ""
			end
		end

		if turn == 1
			puts "You lose"
		else
			puts "You win"
		end
		puts "#{current_player_name} loses"
		puts "Do you want to play again? (y/n)"
		answer = gets.chomp.downcase
		break unless answer == "y"
	end
end

def botEasy(sticks)
	if sticks > 3
		return rand(1..3)
	else
		return rand(1..sticks)
	end
end

def botHard(sticks)
	if (sticks % 4) == 1
		if sticks == 1
			return 1
		else
			return rand(1..3)
		end
	elsif (sticks % 4) == 2
		return 1
	elsif (sticks % 4) == 3
		return 2
	elsif (sticks % 4) == 0
		return 3
	end

	raise "invalid number of sticks???"
end



def runner()
	puts "Pvp or against a bot?"
	mode = gets.chomp.downcase
	if mode == "pvp"
		puts "1d or 2d"
		type = gets.chomp.downcase
		if type == "1d"
			pvp()
		elsif type == "2d"
			pvp2d()
		else
			while (type != "1d") or (type != "2d")
				puts "Invalid input"
				puts "please choose 1d or 2d"
				type = gets.chomp.downcase
			end
		end

	elsif mode == "bot"
		puts "Easy or hard?"
		difficulty = gets.chomp.downcase
		if difficulty == "easy"
			bot("easy")
		elsif difficulty == "hard"
			bot("hard")
		else
			puts "Invalid input"
			while (difficulty != "easy") or (difficulty != "hard")
				puts "Invalid input"
				puts "please choose easy or hard"
				difficulty = gets.chomp.downcase
			end
		end
	end
end

runner()
