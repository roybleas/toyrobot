require "./lib/place"


RSpec.describe Place do
	context "initialise" do
		it "creates a new Place " do
			place = Place.new(x: 1,y: 2,facing: "NORTH")
			
			expect(place.facing).to eq(:NORTH)
			expect(place.point).to eq(Point.new(1,2))
		end
		it "fails with missing keyword parameter" do
			expect{place = Place.new(y: 2,facing: "NORTH")}.to raise_error(ArgumentError,/missing keyword/)
		end
		it "creates with keywords" do
			place = Place.new(facing: "SOUTH", x: 99, y: -1)
			expect(place.facing).to eq(:SOUTH)
			expect(place.point).to eq(Point.new(99,-1))
		end
	end
	context "execute" do
		it "creates a new location" do
			place = Place.new(x: 1,y: 2,facing: "NORTH")
			location = Location.new()
			newLocation = place.execute(location)
			expect(newLocation.direction).to eq(:NORTH)
			expect(newLocation.point).to eq(Point.new(1,2))
		end
		it "ignores original location" do
			place = Place.new(x: 1,y: 2,facing: "NORTH")
			location = Location.new()
			location.setup(direction: :EAST, point: Point.new(3,4))
			newLocation = place.execute(location)
			expect(location.direction).to eq(:EAST)
			expect(location.point).to eq(Point.new(3,4))
		end
		
	end
end