class Report

  def execute(location)
    
    printf "%d,%d,%s \n", location.point.x,location.point.y,location.direction.to_s if location.setup?
    
    return location
  end
end