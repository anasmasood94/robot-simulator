class RobotSimulatorService
  DIRECTIONS = ["NORTH", "EAST", "SOUTH", "WEST"]
  GRID_SIZE = 5
  MOVE_UNIT = 1

  def initialize(x=nil, y=nil, direction=nil)
    place(x, y, direction)
  end

  def place(x, y, direction)
    @x = validate_coordinate(x)
    @y = validate_coordinate(y)
    @direction = validate_direction(direction)
  end

  def simulate command
    x_copy = @x
    y_copy = @y
    direction_copy = @direction

    if command.include? "PLACE"
      result = command.split("(").last.split(")").first.split(",")
      place(result[0].to_i, result[1].to_i, result[2].strip)
    else
      send(command.downcase)
    end
    result = report

    @x = x_copy
    @y = y_copy
    @direction = direction_copy

    result
  end

  def move
    return unless robot_is_placed?

    movement = get_movement
    update_position(movement) if validate_coordinate(movement)
  end

  def left
    return unless robot_is_placed?
    @direction = DIRECTIONS[DIRECTIONS.index(@direction) - 1]
  end

  def right
    return unless robot_is_placed?
    @direction = DIRECTIONS.reverse[DIRECTIONS.reverse.index(@direction) - 1]
  end

  def report
    return unless robot_is_placed?
    "#{@x}, #{@y}, #{@direction}"
  end

  private
    def robot_is_placed?
      @x.present? and @y.present? and @direction.present?
    end

    def validate_coordinate coordinate
      coordinate && coordinate > -1 and coordinate < GRID_SIZE ? coordinate : nil
    end

    def validate_direction direction
      DIRECTIONS.include?(direction) ? direction : nil
    end

    def update_position movement
      if ["NORTH", "SOUTH"].include? @direction
        @y = movement

      else
        @x = movement
      end
    end

    def get_movement
      case @direction
        when "NORTH"
          @y + MOVE_UNIT

        when "EAST"
          @x + MOVE_UNIT

        when "SOUTH"
          @y - MOVE_UNIT

        when "WEST"
          @x - MOVE_UNIT
        end
    end
end

