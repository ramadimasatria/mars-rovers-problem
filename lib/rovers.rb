class Rover
  attr_accessor :pos_x
  attr_accessor :pos_y
  attr_accessor :direction
  attr_accessor :limit_x
  attr_accessor :limit_y

  def initialize(boundaries, initial_state)
    boundarr = boundaries.split(' ')
    @limit_x = boundarr[0].to_i
    @limit_y = boundarr[1].to_i

    statearr = initial_state.split(' ')
    @pos_x = statearr[0].to_i
    @pos_y = statearr[1].to_i
    @direction = statearr[2]
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

    if @pos_y > @limit_y || @pos_y < 0 || @pos_x > @limit_x || @pos_x < 0
      raise "Out of bound"
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

  def get_state
    return "#{@pos_x} #{@pos_y} #{@direction}"
  end

  def run_step(step)
    case step
      when 'L'
        self.rotate_left
      when 'R'
        self.rotate_right
      when 'M'
        self.move
    end
  end

  def run_instructions(instructions)
    steps = instructions.scan /\w/
    steps.each {|s| self.run_step s}
  end
end
