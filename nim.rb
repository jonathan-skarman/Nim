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

		while not_all_empty(sticks)
			if turn == 2
				turn = 1
			else
				turn = 2
			end
      current_player_name = (turn == 1) ? player1_name : player2_name

			puts "#{current_player_name}'s turn"

			puts "what pile do you want to draw from"
			pile = gets.chomp.to_i - 1
			while (!(verify_pile(pile, max, sticks)))
				puts "invalid input, write a number between 1 and #{max}, you can not choose an empty pile"
				pile = gets.chomp.to_i - 1
			end

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

def pvp3d
	puts ""
	puts "Player 1, enter your name:"
	player1_name = gets.chomp
	puts "Player 2, enter your name:"
	player2_name = gets.chomp

	puts "How many piles each, minimum is 2"
	piles_each = gets.chomp.to_i #kanske begränsa
	while (piles_each != piles_each.to_i) or (piles_each < 2)
		puts "You need to write a valid integer, minimum is 2"
		piles_each = gets.chomp.to_i
	end

	active_per_turn = 3
	loop do
		player1_piles = Array.new(0)
		player2_piles = Array.new(0)
		i = 0
		while player1_piles.length < piles_each
			player1_piles.append(rand(1..14))
			player2_piles.append(rand(1..14))
			i += 1
		end

		turn = rand(1..2)
		if turn == 2
			player1_piles.append(rand(1..14))
		else
			player2_piles.append(rand(1..14))
		end

		puts ""
		puts "#{player1_name} has #{player1_piles.sort}"
		puts "#{player2_name} has #{player2_piles.sort}"

#--#--#--#--#
		while (not_all_empty(player1_piles) or not_all_empty(player2_piles))
			if turn == 2
				turn = 1
			else
				turn = 2
			end

      current_player_name = (turn == 1) ? player1_name : player2_name
			current_player_piles = (turn == 1) ? player1_piles : player2_piles
			non_current_player_piles = (turn == 2) ? player1_piles : player2_piles

			puts "#{current_player_name}'s turn"
			current_player_piles = current_player_piles.sort
			first_active_pile = active_pile_start(current_player_piles, active_per_turn)
			if first_active_pile == nil
				raise "problem igen fml"
			end

			if !(not_all_empty(current_player_piles[first_active_pile..(first_active_pile+2)]))
				if !(not_all_empty(current_player_piles))
					break
				end
				first_active_pile = current_player_piles.length - 3
			end

			puts "active piles are #{current_player_piles[first_active_pile..(first_active_pile + active_per_turn - 1)]}"
			puts "what pile do you want to draw from"

			pile = gets.chomp.to_i - 1 + first_active_pile
			while (!(verify_pile_3d(pile, first_active_pile, (first_active_pile + active_per_turn - 1)))) or (current_player_piles[pile] == 0)
				puts "invalid input, write a number between 1 and #{active_per_turn}, you can not choose an empty pile"
				pile = gets.chomp.to_i - 1 + first_active_pile
			end

			if current_player_piles[pile] < 3
				puts "You can take between 1 and #{current_player_piles[pile]} sticks"
				puts "How many do you take"
				input = gets.to_i
				while (!(verify(input)) or (input > current_player_piles[pile]))
					puts "Invalid input, please input a number between 1 and #{current_player_piles[pile]}"
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
			current_player_piles[pile] -= input

			non_current_player_piles.append(current_player_piles[pile])

			if turn == 1
				player1_piles = player1_piles.sort
				player1_piles.delete_at(pile) # AGHHHGGGGHHHJH
			else
				player2_piles = player2_piles.sort
				player2_piles.delete_at(pile) # AGHHHGGGGHHHJH
			end


		puts ""
		puts "#{player1_name} now has #{player1_piles.sort}"
		puts "#{player2_name} now has #{player2_piles.sort}"
#--#--#--#--#

		end

		puts "#{current_player_name} loses"
		puts "Do you want to play again? (y/n)"
		answer = gets.chomp.downcase
		break unless answer == "y"
	end
end

def bot(input)
	if input != "easy" and input != "hard"
		raise "no difficulty selected 2"
	end

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
				if sticks >= 3
					puts "You can take between 1 and 3 sticks"
				else
					puts "You can take between 1 and #{sticks} sticks"
				end

				puts "How many do you take"
					sticks_taken = gets.to_i
					if sticks >= 3
						while !(verify(sticks_taken))
							puts "Invalid input, please input a number between 1 and 3"
							sticks_taken = gets.to_i
						end
					else
						while (!(verify(sticks_taken))) or sticks_taken > sticks
							puts "Invalid input, please input a number between 1 and #{sticks}"
							sticks_taken = gets.to_i
						end
					end
					sticks -= sticks_taken
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

#O(användare)
