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

def verify_pile(input, max)
	if input != input.to_i
		return false
	elsif (input < 1) or (input > max)
		return false
	end
	return true
end

def all_empty(arr)
	#check if all indexes in arr == 0
end
