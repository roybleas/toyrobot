class Report

	def execute(location)
		
		return print "Not placed yet! " unless location.setup?
		
		printf "%d,%d,%s ", location.position.x,location.position.y,location.direction.to_s if location.setup?
		
	end
end