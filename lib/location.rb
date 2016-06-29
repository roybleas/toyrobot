class Point
	attr_accessor :x, :y
	def initialize(x,y)
		@x = x
		@y = y
	end
	
	def ==(another_point)
    self.x == another_point.x && self.y = another_point.y
  end
  
  def within_area?(another_point)
  	return false unless another_point.x <= @x
  	return false unless another_point.x >= 0
  	return false unless another_point.y <= @y
  	return false unless another_point.y >= 0
  	return true
	end
end
