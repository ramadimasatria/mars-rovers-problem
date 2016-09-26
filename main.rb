require_relative 'rovers.rb'

inputstr = gets.chomp
input = []

while inputstr != '' do
  input << inputstr
  inputstr = gets.chomp
end

boundaries = input[0]
rovers = ((input.size - 1) / 2.0).ceil

(1..rovers).each do |idx|
  initial_state = input[(2 * idx) - 1]
  instructions = input[2 * idx]
  rover = Rover.new(boundaries, initial_state)
  rover.run_instructions instructions
  puts rover.get_state
end
