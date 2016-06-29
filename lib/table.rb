class Table
	attr_accessor :size
	def initialize(x = 4,y = 4)
		@size = Point.new(x.to_i, y.to_i)
	end 
	
	def valid_position?(point)
		@size.within_area?(point)
	end
end