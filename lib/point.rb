class PointError < StandardError;end

class Point
  attr_accessor :x, :y
  
  def initialize(x,y)
    @x = x.to_i
    @y = y.to_i
  end
  
  def ==(another_point)
    return nil if another_point.nil?
    (@x == another_point.x) && (@y == another_point.y)
  end
  
  def within_bounds_of?(another_point)
    return false unless another_point.x <= @x
    return false unless another_point.x >= 0
    return false unless another_point.y <= @y
    return false unless another_point.y >= 0
    return true
  end
  
  def add(another_point)
    x = @x + another_point.x
    y = @y + another_point.y
    Point.new(x,y)
  end
end
