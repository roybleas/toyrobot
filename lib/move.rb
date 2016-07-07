require_relative "location"
require_relative "point"

class Move
	ADD_POINT = {:NORTH => Point.new(0,1), 
		:SOUTH => Point.new(0,-1), 
		:WEST => Point.new(-1,0), 
		:EAST => Point.new(1,0)}
	
	def execute(location)
		return location unless location.setup?
	
		new_point = location.point.add(ADD_POINT[location.direction])
		newLocation = new_location(location,new_point)
		
		return newLocation	
		
	end
	
	def new_location(location,point)
		if location.setup?
			newLocation = location.duplicate
			newLocation.point = point
		else
			newLocation = location.clone
		end
		return newLocation
	end
	
end