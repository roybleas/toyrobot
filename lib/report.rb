class Report

	def execute(location)
		
		return print "No location set yet!" unless location.setup?
		
		printf "%d,%d,%s ", location.point.x,location.point.y,location.direction.to_s if location.setup?
		
	end
end