max = 5

sticks = Array.new(0)
i = 0
while sticks.length < max
	sticks.append(rand(1..14))
	i += 1
end

p sticks
