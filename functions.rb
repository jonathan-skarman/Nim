#Beskrivning - kollar om input är en tillåten input
#Arg 1: input - inputen som kommer verifieras
#return: true om det är en tillåten input
#examples:
#			p verify(3) => true
#			p verify(2) => true
#			p verify(1) => true
#date: 17/04/2024
#name: Jonathan Nissov Skarman
def verify(input)
	if input != input.to_i
    return false
		#raise "input är inte siffra"
	elsif !((input == 1) || (input == 2) || (input == 3))
    return false
		#raise "otillåten siffra"
	end
	return true
end

def verify_pile(input, max, sticks)
	if input != input.to_i
		return false
	elsif (input < 0) or (input >= max)
		return false
	elsif sticks[input] == 0
		return false
	elsif sticks[input] == nil
		return false
	end
	return true
end

def verify_pile_3d(input, start, max)
	if input != input.to_i
		return false
	elsif (input < start) or (input > max)
		return false
	end

	return true
end

def not_all_empty(arr)
	i = 0

	while i < arr.length
		if arr[i] != 0
			return true
		end
		i += 1
	end
	return false
end

def active_pile_start(arr, active_per_turn)
	empty = how_many_empty(arr)

	output = (rand(empty..(arr.length - 1 - active_per_turn)))

	if (arr.length - active_per_turn - 1) >= empty
		output = (rand(empty..(arr.length - 1 - active_per_turn)))
	else
		output = arr.length - active_per_turn
	end

	return output
end

def how_many_empty(arr) #sorted array, only int of 0 or over
	i = 0
	while i < arr.length
		if arr[i] != 0
			return i
		end
		i += 1
	end
	return i
end
