
class Turn
			
	def action (location, turn_direction)
		location.direction = turn_direction[location.direction]
		return location
	end

end

class Left < Turn
	TURN_LEFT = {:NORTH => :WEST, :WEST => :SOUTH, :SOUTH => :EAST, :EAST => :NORTH}.freeze
		
	def execute(location)
		self.action(location,TURN_LEFT)
	end
end

class Right < Turn
	TURN_RIGHT = {:NORTH => :EAST, :EAST => :SOUTH, :SOUTH => :WEST, :WEST => :NORTH}.freeze
	
	def execute(location)
		self.action(location,TURN_RIGHT)
	end
end

