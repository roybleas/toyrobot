class Table
  attr_accessor :size
  def initialize(x = 4,y = 4)
    @size = Point.new(x, y)
  end 
  
  def valid_point?(point)
    @size.within_bounds_of?(point)
  end
end