def verify(input)
	if input != input.to_i
		raise "input är inte siffra"
	elsif input != 1 || input != 2 || input != 3
		raise "otillåten siffra"
	end
	return input
end

def pvp()
	sticks = rand(4..14)
	turn = rand(1..2)
	puts "There are #{sticks} sticks"

	while (sticks != 0)
		if turn == 2
			turn = 1
		else
			turn = 2
		end

		puts "Player #{turn} begins"
		puts "You can take between 1 and 3 sticks"
		puts "How many do you take"
		sticks -= verify(gets.to_i)
		puts "There are now #{sticks} sticks"
	end
	puts "Player #{turn} losses"
	return
end

pvp()

def botEasy()
end

def botHard()
end



def runner()
	puts "Vill du spela pvp eller bot"
	mode = gets.chomp.downcase
	if mode == "pvp"
		pvp()

	elsif mode == "bot"
		puts "Vill du spela mot en lätt bot eller en svår bot"
		difficulty = gets.chomp.downcase
		if difficulty == "easy"
			botEasy()
		elsif difficulty == "hard"
			botHard()
		end
	end
end

#runner()
