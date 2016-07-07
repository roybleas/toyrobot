class PointError < StandardError;end

class Point
	attr_accessor :x, :y
	def initialize(x,y)
		@x = x.to_i
		@y = y.to_i
	end
	
	def ==(another_point)
		return nil if another_point.nil?
    (@x == another_point.x) && (@y == another_point.y)
  end
  
  def within_bounds_of?(another_point)
  	return false unless another_point.x <= @x
  	return false unless another_point.x >= 0
  	return false unless another_point.y <= @y
  	return false unless another_point.y >= 0
  	return true
	end
	
	def add(another_point)
		x = @x + another_point.x
		y = @y + another_point.y
		Point.new(x,y)
	end
end

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
