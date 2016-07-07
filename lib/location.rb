
class Location
  attr_accessor :direction, :point
  
  VALID_DIRECTIONS = [:NORTH, :SOUTH, :EAST, :WEST].freeze
  
  def setup(direction: , point: )
    if VALID_DIRECTIONS.include?(direction)
      @direction = direction
      @point = point
      return self
    end
  end
      
  def direction=(direction)
    if setup?
      @direction = direction if VALID_DIRECTIONS.include?(direction)
    end
  end
  
  def duplicate
    location = Location.new()
    location.point = @point
    location.direction = @direction
    return location
  end
  
  def setup?
    return true unless @direction.nil? && @point.nil?
    false
  end
end
