require "./lib/move"
require "./lib/location"


RSpec.describe Move do
	context "execute" do
		let(:command) {Move.new()}
		let(:location) {Location.new()}
		it "increases x coordinate by 1 when when facing EAST" do
			location.setup(direction: :EAST, point: Point.new(0,0))
			new_location = command.execute(location)
			expect(new_location.point).to eq(Point.new(1,0))
		end 
		it "increases y coordinate by 1 when when facing NORTH" do
			location.setup(direction: :NORTH, point: Point.new(0,0))
			new_location = command.execute(location)
			expect(new_location.point).to eq(Point.new(0,1))
		end 
		it "decreases x coordinate by 1 when when facing WEST" do
			location.setup(direction: :WEST, point: Point.new(4,4))
			new_location = command.execute(location)
			expect(new_location.point).to eq(Point.new(3,4))
		end 
		it "decreases y coordinate by -1 when when facing SOUTH" do
			location.setup(direction: :SOUTH, point: Point.new(4,4))
			new_location = command.execute(location)
			expect(new_location.point).to eq(Point.new(4,3))
		end 
	end
	context "location not set" do
		it "returns original location" do
			location = Location.new()
			command = Move.new()
			new_location = command.execute(location)
			expect(new_location).to eq(location)
		end
	end
	context "new location" do
		let(:myNewpoint) {Point.new(3,4)}
		let(:move) {Move.new}
		it "ignore point when nil" do
			nil_location = Location.new()
			newLocation = move.new_location(nil_location,myNewpoint)  
			
			expect(newLocation.point).to be_nil
			expect(newLocation.direction).to be_nil
			expect(nil_location.point).to be_nil
			expect(nil_location.direction).to be_nil						
		end
		
		it "create location with new point" do
			myPoint = Point.new(1,2)   
			current_location = Location.new
			current_location.setup(direction: :EAST, point: myPoint )  
			newLocation = move.new_location(current_location, myNewpoint) 
			 
			expect(newLocation.point).to eq(myNewpoint)
			expect(newLocation.direction).to eq(:EAST)
			expect(current_location.point).to eq(myPoint)
			expect(current_location.direction).to eq(:EAST)						
		end
	end
end