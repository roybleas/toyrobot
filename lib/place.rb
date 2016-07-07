
class Place
  attr_reader :point, :facing
  def initialize(x: , y: , facing:)
    @facing = facing.to_sym
    @point = Point.new(x.to_i,y.to_i)
  end
  
  def execute(location)
    Location.new.setup(direction: @facing, point: @point) 
  end
end