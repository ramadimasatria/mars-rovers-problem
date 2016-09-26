require 'rails_helper'
require_relative '../../lib/rovers.rb'

RSpec.describe Rover do
  describe '#initialize' do
    let(:boundaries) { '5 5' }
    let(:initial_state) { '1 2 N' }

    it 'should receive "boundaries" and "initial_state" as args' do
      rover = Rover.new(boundaries, initial_state)
    end

    it 'should set @pos_x, @pos_y, @direction, @limit_x and @limit_y attributes ' do
      rover = Rover.new(boundaries, initial_state)

      expect(rover.pos_x).to eq(1)
      expect(rover.pos_y).to eq(2)
      expect(rover.direction).to eq('N')
      expect(rover.limit_x).to eq(5)
      expect(rover.limit_y).to eq(5)
    end
  end

  describe '#move' do
    let(:boundaries) { '5 5' }

    context 'when direction is "N"' do
      it 'should add pos_y by 1' do
        rover = Rover.new(boundaries, '1 1 N')
        rover.move
        expect(rover.pos_y).to eq(2)
      end
    end

    context 'when direction is "E"' do
      it 'should add pos_x by 1' do
        rover = Rover.new(boundaries, '1 1 E')
        rover.move
        expect(rover.pos_x).to eq(2)
      end
    end

    context 'when direction is "S"' do
      it 'should substract pos_y by 1' do
        rover = Rover.new(boundaries, '1 1 S')
        rover.move
        expect(rover.pos_y).to eq(0)
      end
    end

    context 'when direction is "W"' do
      it 'should substract pos_x by 1' do
        rover = Rover.new(boundaries, '1 1 W')
        rover.move
        expect(rover.pos_x).to eq(0)
      end
    end
  end

  describe '#rotate_left' do
    let(:boundaries) { '5 5' }

    context 'when initial direction is "N"' do
      it 'should change direction to "W"' do
        rover = Rover.new(boundaries, '0 0 N')
        rover.rotate_left
        expect(rover.direction).to eq('W')
      end
    end

    context 'when initial direction is "E"' do
      it 'should change direction to "N"' do
        rover = Rover.new(boundaries, '0 0 E')
        rover.rotate_left
        expect(rover.direction).to eq('N')
      end
    end

    context 'when initial direction is "S"' do
      it 'should change direction to "E"' do
        rover = Rover.new(boundaries, '0 0 S')
        rover.rotate_left
        expect(rover.direction).to eq('E')
      end
    end

    context 'when initial direction is "W"' do
      it 'should change direction to "S"' do
        rover = Rover.new(boundaries, '0 0 W')
        rover.rotate_left
        expect(rover.direction).to eq('S')
      end
    end
  end

  describe '#rotate_right' do
    let(:boundaries) { '5 5' }

    context 'when initial direction is "N"' do
      it 'should change direction to "E"' do
        rover = Rover.new(boundaries, '0 0 N')
        rover.rotate_right
        expect(rover.direction).to eq('E')
      end
    end

    context 'when initial direction is "E"' do
      it 'should change direction to "S"' do
        rover = Rover.new(boundaries, '0 0 E')
        rover.rotate_right
        expect(rover.direction).to eq('S')
      end
    end

    context 'when initial direction is "S"' do
      it 'should change direction to "W"' do
        rover = Rover.new(boundaries, '0 0 S')
        rover.rotate_right
        expect(rover.direction).to eq('W')
      end
    end

    context 'when initial direction is "W"' do
      it 'should change direction to "N"' do
        rover = Rover.new(boundaries, '0 0 W')
        rover.rotate_right
        expect(rover.direction).to eq('N')
      end
    end
  end

  describe '#get_state' do
    let(:boundaries) { '5 5' }

    it 'should return last position and direction' do
      rover = Rover.new(boundaries, '0 0 N')
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
    let(:boundaries) { '5 5' }

    context 'when given step "L"' do
      it 'should run #rotate_left method' do
        rover = Rover.new(boundaries, '0 0 N')
        expect(rover).to receive(:rotate_left)

        rover.run_step('L')
      end
    end

    context 'when given step "R"' do
      it 'should run #rotate_right method' do
        rover = Rover.new(boundaries, '0 0 N')
        expect(rover).to receive(:rotate_right)

        rover.run_step('R')
      end
    end

    context 'when given step "M"' do
      it 'should run #move method' do
        rover = Rover.new(boundaries, '0 0 N')
        expect(rover).to receive(:move)

        rover.run_step('M')
      end
    end
  end

  describe '#run_instructions' do
    let(:boundaries) { '5 5' }

    context 'when given valid set of instructions' do
      it 'should invoke #run_step on every step' do
        rover = Rover.new(boundaries, '0 0 N')
        expect(rover).to receive(:run_step).exactly(5).times

        instructions = 'MMLLR'
        rover.run_instructions instructions
      end

      it 'should give correct end position' do
        # test case 1
        rover1 = Rover.new(boundaries, '1 2 N')
        rover1.run_instructions('LMLMLMLMM')
        expect(rover1.get_state).to eq('1 3 N')

        # test case 2
        rover2 = Rover.new(boundaries, '3 3 E')
        rover2.run_instructions('MMRMMRMRRM')
        expect(rover2.get_state).to eq('5 1 E')
      end
    end
  end
end
