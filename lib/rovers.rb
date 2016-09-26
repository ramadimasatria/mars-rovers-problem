class Rover
  attr_accessor :pos_x
  attr_accessor :pos_y
  attr_accessor :direction

  def initialize(pos_x, pos_y, direction)
    @pos_x = pos_x
    @pos_y = pos_y
    @direction = direction
  end

  def move
    case @direction
      when 'N'
        @pos_y = @pos_y + 1
      when 'E'
        @pos_x = @pos_x + 1
      when 'S'
        @pos_y = @pos_y - 1
      when 'W'
        @pos_x = @pos_x - 1
    end
  end

  def rotate_left
    case @direction
      when 'N'
        @direction = 'W'
      when 'E'
        @direction = 'N'
      when 'S'
        @direction = 'E'
      when 'W'
        @direction = 'S'
    end
  end

  def rotate_right
    case @direction
      when 'N'
        @direction = 'E'
      when 'E'
        @direction = 'S'
      when 'S'
        @direction = 'W'
      when 'W'
        @direction = 'N'
    end
  end
end
