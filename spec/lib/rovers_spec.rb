require 'rails_helper'
require_relative '../../lib/rovers.rb'

RSpec.describe Rover do
  describe '#initialize' do
    it 'should receive "pos_x", "pos_y" and "direction" as args and set to instance attribute' do
      rover = Rover.new(2, 3, 'N')

      expect(rover.pos_x).to eq(2)
      expect(rover.pos_y).to eq(3)
      expect(rover.direction).to eq('N')
    end
  end

  describe '#move' do
    context 'when direction is "N"' do
      it 'should add pos_y by 1' do
        rover = Rover.new(1, 1, 'N')
        rover.move
        expect(rover.pos_y).to eq(2)
      end
    end

    context 'when direction is "E"' do
      it 'should add pos_x by 1' do
        rover = Rover.new(1, 1, 'E')
        rover.move
        expect(rover.pos_x).to eq(2)
      end
    end

    context 'when direction is "S"' do
      it 'should substract pos_y by 1' do
        rover = Rover.new(1, 1, 'S')
        rover.move
        expect(rover.pos_y).to eq(0)
      end
    end

    context 'when direction is "W"' do
      it 'should substract pos_x by 1' do
        rover = Rover.new(1, 1, 'W')
        rover.move
        expect(rover.pos_x).to eq(0)
      end
    end
  end

  describe '#rotate_left' do
    context 'when initial direction is "N"' do
      it 'should change direction to "W"' do
        rover = Rover.new(0, 0, 'N')
        rover.rotate_left
        expect(rover.direction).to eq('W')
      end
    end

    context 'when initial direction is "E"' do
      it 'should change direction to "N"' do
        rover = Rover.new(0, 0, 'E')
        rover.rotate_left
        expect(rover.direction).to eq('N')
      end
    end

    context 'when initial direction is "S"' do
      it 'should change direction to "E"' do
        rover = Rover.new(0, 0, 'S')
        rover.rotate_left
        expect(rover.direction).to eq('E')
      end
    end

    context 'when initial direction is "W"' do
      it 'should change direction to "S"' do
        rover = Rover.new(0, 0, 'W')
        rover.rotate_left
        expect(rover.direction).to eq('S')
      end
    end
  end

  describe '#rotate_right' do
    context 'when initial direction is "N"' do
      it 'should change direction to "E"' do
        rover = Rover.new(0, 0, 'N')
        rover.rotate_right
        expect(rover.direction).to eq('E')
      end
    end

    context 'when initial direction is "E"' do
      it 'should change direction to "S"' do
        rover = Rover.new(0, 0, 'E')
        rover.rotate_right
        expect(rover.direction).to eq('S')
      end
    end

    context 'when initial direction is "S"' do
      it 'should change direction to "W"' do
        rover = Rover.new(0, 0, 'S')
        rover.rotate_right
        expect(rover.direction).to eq('W')
      end
    end

    context 'when initial direction is "W"' do
      it 'should change direction to "N"' do
        rover = Rover.new(0, 0, 'W')
        rover.rotate_right
        expect(rover.direction).to eq('N')
      end
    end
  end

  describe '#get_state' do
    it 'should return last position and direction' do
      rover = Rover.new(0,0,'N')
      rover.move
      rover.move
      rover.rotate_right
      rover.move

      expect(rover.pos_x).to eq(1)
      expect(rover.pos_y).to eq(2)
      expect(rover.direction).to eq('E')
      expect(rover.get_state).to eq('1 2 E')
    end
  end

  describe '#run_step' do
    context 'when given step "L"' do
      it 'should run #rotate_left method' do
        rover = Rover.new(0, 0, 'N')
        expect(rover).to receive(:rotate_left)

        rover.run_step('L')
      end
    end

    context 'when given step "R"' do
      it 'should run #rotate_right method' do
        rover = Rover.new(0, 0, 'N')
        expect(rover).to receive(:rotate_right)

        rover.run_step('R')
      end
    end

    context 'when given step "M"' do
      it 'should run #move method' do
        rover = Rover.new(0, 0, 'N')
        expect(rover).to receive(:move)

        rover.run_step('M')
      end
    end
  end

  describe '#run_instructions' do
    context 'when given valid set of instructions' do
      it 'should invoke #run_step on every step' do
        rover = Rover.new(0, 0, 'N')
        expect(rover).to receive(:run_step).exactly(5).times

        instructions = 'MMLLR'
        rover.run_instructions instructions
      end
    end
  end
end
