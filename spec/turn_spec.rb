require "./lib/turn"
require "./lib/location"


RSpec.describe Left do
	context "execute" do
		
		let(:location) {Location.new()}
		let(:command) {Left.new()}
		
		it "turns west to south" do
			location.setup(direction: :WEST, point: Point.new(2,3))
			expect(command.execute(location).direction).to eq(:SOUTH)
		end
		it "turns south to east" do
			location.setup(direction: :SOUTH, point: Point.new(2,3))
			expect(command.execute(location).direction).to eq(:EAST)	
		end
		it "turns east to north" do
			location.setup(direction: :EAST, point: Point.new(2,3))
			expect(command.execute(location).direction).to eq(:NORTH)	
		end
		it "turns north to west" do
			location.setup(direction: :NORTH,point: Point.new(2,3))
			expect(command.execute(location).direction).to eq(:WEST)	
		end
	end
	context "without location set" do
		it "ignores command" do
			location = Location.new()
			command = Left.new()
			expect(command.execute(location).direction).to be_nil
		end
	end
end

RSpec.describe Right do
	context "execute" do
		
		let(:location) {Location.new()}
		let(:command) {Right.new()}
		
		it "turns west to north" do
			location.setup(direction: :WEST, point: Point.new(2,3))
			expect(command.execute(location).direction).to eq(:NORTH)
		end
		it "turns south to west" do
			location.setup(direction: :SOUTH, point: Point.new(2,3))
			expect(command.execute(location).direction).to eq(:WEST)	
		end
		it "turns east to south" do
			location.setup(direction: :EAST,point: Point.new(2,3))
			expect(command.execute(location).direction).to eq(:SOUTH)	
		end
		it "turns north to west" do
			location.setup(direction: :NORTH, point: Point.new(2,3))
			expect(command.execute(location).direction).to eq(:EAST)	
		end
	end
	context "without location set" do
		it "ignores command" do
			location = Location.new()
			command = Right.new()
			expect(command.execute(location).direction).to be_nil
		end
	end

end
