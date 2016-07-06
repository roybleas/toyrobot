require "./lib/robot"
require "./lib/commandfactory"

RSpec.describe Robot do
	context "attributes" do
		it "has a default table object" do
			expect(robot = Robot.new().table).to be_a(Table)
		end
		it "has a location" do
			expect(robot = Robot.new().current_location).to be_a(Location)
		end
	end
	context "validates text input file " do 
		let(:robot) {Robot.new()}
		
		context "creates an array of commands" do
		
			it "accepts text and outputs an empty array" do
				robot.feed_instructions("")
				expect(robot.command_list).to be_empty
			end
			it "parses a string and adds valid command to command_list" do
				robot.feed_instructions("MOVE")
				expect(robot.command_list[0]).to be_a(Move)
			end
			it "appends multiple commands to list" do
				robot.feed_instructions("MOVE LEFT PLACE 0,1,WEST MOVE")
				expect(robot.command_list[0]). to be_a(Move)
				expect(robot.command_list[1]). to be_a(Left)
				expect(robot.command_list[2]). to be_a(Place)
				expect(robot.command_list[3]). to be_a(Move)
			end
		end
		context "rejects invalid instructions text" do
			it "rejects lowercase instructions" do
				expect{robot.feed_instructions("MOVE place 0,0,North")}.to raise_error(CommandParserError, /Invalid instruction at 5 : place/ )
			end
		end
	end	
	context "runs instruction set" do
		let(:robot) {Robot.new()}
		context "has no current location set" do
			it "when an empty command list" do
				robot.command_list = []
				robot.run
				expect(robot.current_location.setup?).to be_falsey
			end
			it "when command list has no Place command" do
				robot.command_list = [Move.new, Left.new, Right.new, Move.new, Report.new]
				robot.run
				expect(robot.current_location.setup?).to be_falsey
			end

		end 
		context "has a current location" do
			let(:place_1) {Place.new(x: 1,y: 2,facing: "NORTH")}
			it "when executes a valid Place command" do
						
				robot.command_list = [place_1]
				robot.run
				expect(robot.current_location.setup?).to be_truthy
				expect(robot.current_location.direction).to eq(:NORTH)
				expect(robot.current_location.point).to eq(Point.new(1,2))
			end
			it "when updates Place command" do
				x = 3
				y = 4
				f = "WEST"
				place_2 = Place.new(x: x,y: y,facing: f)		
				robot.command_list = [place_1, place_2]
				
				robot.run
				expect(robot.current_location.setup?).to be_truthy
				expect(robot.current_location.direction).to eq(f.to_sym)
				expect(robot.current_location.point).to eq(Point.new(x,y))
			end
		end	
		context "ignores change of location" do
			it "when placed outside x - area" do
				valid_place = Place.new(x: 4,y: 4,facing: "NORTH")
				invalid_place = Place.new(x: 5,y: 4,facing: "SOUTH")
				robot.command_list = [valid_place, invalid_place]
				robot.run
				expect(robot.current_location.setup?).to be_truthy
				expect(robot.current_location.direction).to eq(:NORTH)
				expect(robot.current_location.point).to eq(Point.new(4,4))
			end
			it "when placed outside y - area" do
				valid_place = Place.new(x: 4,y: 4,facing: "NORTH")
				invalid_place = Place.new(x: 4,y: 5,facing: "SOUTH")
				robot.command_list = [valid_place, invalid_place]
				robot.run
				expect(robot.current_location.setup?).to be_truthy
				expect(robot.current_location.direction).to eq(:NORTH)
				expect(robot.current_location.point).to eq(Point.new(4,4))
			end
			it "when attempts to move outside x coordinate - area" do
				valid_place = Place.new(x: 4,y: 4,facing: "NORTH")
				invalid_move = Move.new
				robot.command_list = [valid_place, invalid_move]
				robot.run
				expect(robot.current_location.setup?).to be_truthy
				expect(robot.current_location.direction).to eq(:NORTH)
				expect(robot.current_location.point).to eq(Point.new(4,4))
			end
			it "when attempts to move before x coordinate - area" do
				valid_place = Place.new(x: 0,y: 4,facing: "SOUTH")
				invalid_move = Move.new
				robot.command_list = [valid_place, invalid_move]
				robot.run
				expect(robot.current_location.setup?).to be_truthy
				expect(robot.current_location.direction).to eq(:SOUTH)
				expect(robot.current_location.point).to eq(Point.new(0,4))
			end
			it "when attempts to move outside y coordinate - area" do
				valid_place = Place.new(x: 4,y: 4,facing: "EAST")
				invalid_move = Move.new
				robot.command_list = [valid_place, invalid_move]
				robot.run
				expect(robot.current_location.setup?).to be_truthy
				expect(robot.current_location.direction).to eq(:EAST)
				expect(robot.current_location.point).to eq(Point.new(4,4))
			end
			it "when attempts to move before y coordinate - area" do
				valid_place = Place.new(x: 4,y: 0,facing: "WEST")
				invalid_move = Move.new
				robot.command_list = [valid_place, invalid_move]
				robot.run
				expect(robot.current_location.setup?).to be_truthy
				expect(robot.current_location.direction).to eq(:WEST)
				expect(robot.current_location.point).to eq(Point.new(4,0))
			end

		end
	end
end