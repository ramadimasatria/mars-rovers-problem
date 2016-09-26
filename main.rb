require_relative 'rovers.rb'

puts "Input:"

boundaries = gets.chomp

initial_state1 = gets.chomp
instructions1 = gets.chomp

initial_state2 = gets.chomp
instructions2 = gets.chomp

puts "Output:"

rover1 = Rover.new(boundaries, initial_state1)
rover1.run_instructions(instructions1)
puts rover1.get_state


rover2 = Rover.new(boundaries, initial_state2)
rover2.run_instructions(instructions2)
puts rover2.get_state
