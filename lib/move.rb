require_relative "location"

class Move
	ADD_POINT = {:NORTH => Point.new(0,1), 
		:SOUTH => Point.new(0,-1), 
		:WEST => Point.new(-1,0), 
		:EAST => Point.new(1,0)}
	
	def execute(location)
		return location unless location.setup?
	
		new_point = location.point.add(ADD_POINT[location.direction])
		new_location = location.new_point(new_point)
		return new_location	
		
	end
	
end