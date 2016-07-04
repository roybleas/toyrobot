
TURN_LEFT = {:NORTH => :WEST, :WEST => :SOUTH, :SOUTH => :EAST, :EAST => :NORTH}
TURN_RIGHT = {:NORTH => :EAST, :EAST => :SOUTH, :SOUTH => :WEST, :WEST => :NORTH}

class Turn
			
	def execute (location, turn_direction)
		location.direction = turn_direction[location.direction]
		location
	end
end

class Left < Turn
	
	def execute(location)
		super(location,TURN_LEFT)
	end
end

class Right < Turn
	def execute(location)
		super(location,TURN_RIGHT)
	end

end

