require "./lib/commandfactory"


RSpec.describe CommandFactory do
	context "creates command object" do
		it "MOVE" do
			expect(CommandFactory.create("MOVE")).to be_a(Move)
		end
		it "LEFT" do
			expect(CommandFactory.create("LEFT")).to be_a(Left)
		end
		it "RIGHT" do
			expect(CommandFactory.create("RIGHT")).to be_a(Right)
		end
		it "REPORT" do
			expect(CommandFactory.create("REPORT")).to be_a(Report)
		end
		it "PLACE" do
			expect(CommandFactory.create("PLACE 0,1,WEST")).to be_a(Place)
		end
	end
	context "Place object" do
		it "has facing" do
			expect(CommandFactory.create("PLACE 0,1,WEST").facing).to eq(:WEST)
		end
		it "has a point" do
			expect(CommandFactory.create("PLACE 0,1,WEST").point).to be == Point.new(0,1)
		end
	end
	context "unknown object type" do
		it "raises an error" do
			expect{CommandFactory.create("notacommand")}.to raise_error(CommandFactoryError,/Invalid Command type: notacommand/)
		end
	end
end
