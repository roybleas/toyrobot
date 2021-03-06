require "./lib/move"
require "./lib/location"


RSpec.describe Report do
  context "execute" do    
    it "outputs current location" do
      location = Location.new.setup(direction: :WEST, point: Point.new(1,0))
      command = Report.new
      expect{command.execute(location)}.to output(/1,0,WEST/).to_stdout 
    end
    it "outputs nothing when no current location" do
      location = Location.new
      command = Report.new
      expect{command.execute(location)}.to_not output.to_stdout
    end
  end
end