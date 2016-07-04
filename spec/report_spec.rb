require "./lib/move"
require "./lib/location"


RSpec.describe Report do
	context "execute" do
		it "outputs location" do
			location = Location.new()
			location.setup(direction: :WEST, position: Point.new(1,0))
			command = Report.new()
			expect{command.execute(location)}.to output(/1,0,WEST/).to_stdout 
		end
	end
end