require_relative 'rovers.rb'

boundaries = gets.chomp
initial_state = gets.chomp
instructions = gets.chomp

rover = Rover.new(boundaries, initial_state)
rover.run_instructions(instructions)
puts rover.get_state
