require "./lib/move"
require "./lib/location"


RSpec.describe Move do
	context "execute" do
		let(:command) {Move.new()}
		let(:location) {Location.new()}
		it "increases x coordinate by 1 when when facing north" do
			location.setup(direction: :NORTH, position: Point.new(0,0))
			new_location = command.execute(location)
			expect(new_location.position).to eq(Point.new(1,0))
		end 
		it "increases y coordinate by 1 when when facing East" do
			location.setup(direction: :EAST, position: Point.new(0,0))
			new_location = command.execute(location)
			expect(new_location.position).to eq(Point.new(0,1))
		end 
		it "decreases x coordinate by 1 when when facing south" do
			location.setup(direction: :SOUTH, position: Point.new(4,4))
			new_location = command.execute(location)
			expect(new_location.position).to eq(Point.new(3,4))
		end 
		it "decreases y coordinate by -1 when when facing west" do
			location.setup(direction: :WEST, position: Point.new(4,4))
			new_location = command.execute(location)
			expect(new_location.position).to eq(Point.new(4,3))
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
end