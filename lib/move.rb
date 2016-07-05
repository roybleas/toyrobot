require 'location'
class Move
	ADD_POINT = {:NORTH => Point.new(1,0), 
		:SOUTH => Point.new(-1,0), 
		:WEST => Point.new(0,-1), 
		:EAST => Point.new(0,1)}
	
	def execute(location)
		return location unless location.setup?
	
		new_point = location.point.add(ADD_POINT[location.direction])
		new_location = location.new_point(new_point)
		return new_location	
		
	end
	
end