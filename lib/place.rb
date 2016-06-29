require 'location'

class Place
	attr_reader :position, :facing
	def initialize(x: , y: , facing:)
		@facing = facing.to_sym
		@position = Point.new(x.to_i,y.to_i)
	end
end