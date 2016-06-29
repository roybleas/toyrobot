class Point
	attr_accessor :x, :y
	def initialize(x,y)
		@x = x
		@y = y
	end
	
	def ==(another_point)
    self.x == another_point.x && self.y = another_point.y
  end
end
