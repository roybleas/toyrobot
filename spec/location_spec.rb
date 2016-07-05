require "./lib/location"


RSpec.describe Point do
	context "create point objects" do
		it "creates from new object"  do
			expect(Point.new(2,3)).to be_a(Point)
		end
	end
	context "valid coordiates" do
		it "accepts numeric coordinates" do
			point = Point.new(1,2)
			expect(point.x).to eq 1
			expect(point.y).to eq 2
		end
		it "converts string parameters to integers" do
			point = Point.new("1","2")
			expect(point.x).to eq 1
			expect(point.y).to eq 2
		end		
		it "converts float to integers" do
			point = Point.new(1.2,3.5)
			expect(point.x).to eq 1
			expect(point.y).to eq 3
		end
	end
	context "area test" do
		let(:point) {Point.new(4,4)}
		context "outside area" do
			it "returns false when x > point" do
				expect(point.within_bounds_of?(Point.new(5,0))).to be_falsey
			end
			it "returns false when x < 0" do
				expect(point.within_bounds_of?(Point.new(-1,0))).to be_falsey
			end
			it "returns false when y > point" do
				expect(point.within_bounds_of?(Point.new(0,5))).to be_falsey
			end
			it "returns false when y < 0" do
				expect(point.within_bounds_of?(Point.new(0,-10))).to be_falsey
			end
		end
		context "inside area" do
			it "returns false when x <= point" do
				expect(point.within_bounds_of?(Point.new(4,0))).to be_truthy
			end
			it "returns true when x >= 0" do
				expect(point.within_bounds_of?(Point.new(0,0))).to be_truthy
			end
			it "returns true when y <= point" do
				expect(point.within_bounds_of?(Point.new(0,4))).to be_truthy
			end
			it "returns true when y >= 0" do
				expect(point.within_bounds_of?(Point.new(0,0))).to be_truthy
			end
			it "returns true when valid x and y" do
				expect(point.within_bounds_of?(Point.new(0,0))).to be_truthy
			end
		end
	end 
	context "compare points" do
		it "returns true when x and y match" do
			expect(Point.new(1,0) == Point.new(1,0)).to be_truthy
		end
		it "returns false when x match and y does not" do
			expect(Point.new(1,0) == Point.new(1,1)).to be_falsey
		end
		it "returns false when y match and x does not" do
			expect(Point.new(1,2) == Point.new(1,3)).to be_falsey
		end		
		it "returns nil when compared to nil" do
			expect(Point.new(1,2) == nil).to be_nil
		end
	end
	context "add points" do
		let(:p1) {Point.new(4,5)}
		it "increase x coordinate" do
			p2 = Point.new(2,0)
			p3 = p1.add(p2)
			expect(p3.x).to eq(6)
			expect(p3.y).to eq(5)
		end
		it "increase y coordinate" do
			p2 = Point.new(0,5)
			p3 = p1.add(p2)
			expect(p3.x).to eq(4)
			expect(p3.y).to eq(10)
		end
		it "decrease x coordinates" do
			p2 = Point.new(-6,0)
			p3 = p1.add(p2)
			expect(p3.x).to eq(-2)
			expect(p3.y).to eq(5)
		end
		it "decrease y coordinates" do
			p2 = Point.new(0,-1)
			p3 = p1.add(p2)
			expect(p3.x).to eq(4)
			expect(p3.y).to eq(4)
		end
		it "increase both coordinates" do
			p2 = Point.new(1,2)
			p3 = p1.add(p2)
			expect(p3.x).to eq(5)
			expect(p3.y).to eq(7)
		end
	end
end

RSpec.describe Location do
	context "setup a location" do
		let(:location) {Location.new()}
		let(:myPoint)  {Point.new(1,0)}
		it " sets direction" do          
			expect(location.setup?).to be_falsey
			location.setup(direction: :NORTH, point: myPoint)
			expect(location.direction).to eq(:NORTH)
			expect(location.point).to eq(myPoint)
			expect(location.setup?).to be_truthy
		end
		it "ignores setup when invalid direction" do
			location.setup(direction: :BAD, point: myPoint)
			expect(location.setup?).to be_falsey
		end
	end
	context "new location" do
		let(:mypoint) {Point.new(1,2)}
		let(:location) {loc = Location.new()
			loc.setup(direction: :EAST, point: mypoint)
			loc} 
		it "by point" do
			myNewpoint = Point.new(3,4)     
			newLocation = location.new_point(myNewpoint)  
			
			expect(newLocation.point).to eq(myNewpoint)
			expect(newLocation.direction).to eq(:EAST)
			expect(location.point).to eq(mypoint)
			expect(location.direction).to eq(:EAST)						
		end
		it "ignore point when nil" do
			nil_location = Location.new()
			myNewpoint = Point.new(3,4)     
			newLocation = nil_location.new_point(myNewpoint)  
			
			expect(newLocation.point).to be_nil
			expect(newLocation.direction).to be_nil
			expect(nil_location.point).to be_nil
			expect(nil_location.direction).to be_nil						
		end
		
		it "by face" do
			location.direction = :SOUTH
			expect(location.point).to eq(mypoint)
			expect(location.direction).to eq(:SOUTH)						
		end
		it "ignore when nil" do
			nil_location = Location.new()
			nil_location.direction = :newFace
			expect(nil_location.point).to be_nil
			expect(nil_location.direction).to be_nil						
		end

	end
end