require 'location'
class Move
	ADD_POSITION = {:NORTH => Point.new(1,0), 
		:SOUTH => Point.new(-1,0), 
		:WEST => Point.new(0,-1), 
		:EAST => Point.new(0,1)}
	
	def execute(location)
		return location unless location.setup?
	
		new_position = location.position.add(ADD_POSITION[location.direction])
		new_location = location.newPosition(new_position)
		return new_location	
		
	end
	
end