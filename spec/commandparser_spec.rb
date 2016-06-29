require "./lib/commandparser"


RSpec.describe CommandParser do
	describe "reads a string of instructions" do
		let(:commandParser) {CommandParser.new()} 
		context "when no instructions" do
			it "creates an empty array with an empty input string" do
				expect(commandParser.parse("")).to be_empty
			end
			it "ignores white space " do
				expect(commandParser.parse("   \n  ")).to be_empty
			end
		end
		context "known instructions" do
			it "include MOVE" do
				expect(commandParser.parse("MOVE")).to eq ["MOVE"]
			end
			it "include REPORT" do
				expect(commandParser.parse("REPORT ")).to eq ["REPORT"]
			end			
			it "include LEFT" do
				expect(commandParser.parse("LEFT ")).to eq ["LEFT"]
			end
			it "include RIGHT" do
				expect(commandParser.parse("RIGHT ")).to eq ["RIGHT"]
			end
			it "include PLACE d,d,f" do
				expect(commandParser.parse("PLACE 0,1,WEST ")).to eq ["PLACE 0,1,WEST"]
			end
		end
		context "multiple known instructions" do
			it "3 MOVEs" do
				expect(commandParser.parse("MOVE MOVE MOVE")).to eq ["MOVE","MOVE", "MOVE"]
			end
			it "combined" do
				expect(commandParser.parse("PLACE 2,4,SOUTH MOVE RIGHT LEFT REPORT")).to eq ["PLACE 2,4,SOUTH", "MOVE", "RIGHT", "LEFT", "REPORT"]
			end
		end
		context "unknown instructions" do
			it "raise error" do
				expect{commandParser.parse("unknown-instruction")}.to raise_error(CommandParserError,/Invalid instruction at 0 : unknown/)
			end
		end
		context "Invalid instructions" do
			it "raises error when invalid spacing" do
				expect{commandParser.parse(" LEFT  RIGHT ")}.to raise_error(CommandParserError,/Invalid instruction at 5 :  RIGHT /)
			end 
		end
		context "Invalid PLACE instructions" do
			it "raises an error when facing is invalid" do
				expect{commandParser.parse("PLACE 0,0,WRONG")}.to raise_error(CommandParserError,/Invalid PLACE instruction : PLACE 0,0,WRONG/)
			end
			it "raises an error when x is > than table size" do
				expect{commandParser.parse("PLACE 5,0,NORTH")}.to raise_error(CommandParserError,/Invalid PLACE instruction : PLACE 5,0,NORTH/)
			end
			it "raises an error when y is > than table size" do
				expect{commandParser.parse("PLACE 1,5,SOUTH")}.to raise_error(CommandParserError,/Invalid PLACE instruction : PLACE 1,5,SOUTH/)
			end
			it "raises an error when facing is not all upper case" do
				expect{commandParser.parse("PLACE 1,2,south")}.to raise_error(CommandParserError,/Invalid PLACE instruction : PLACE 1,2,south/)
			end
		end
		context "Valid PLACE instructions" do
			it "does not raise an error when facing is NORTH, EAST, SOUTH, WEST" do
				expect{commandParser.parse("PLACE 0,4,NORTH PLACE 1,3,EAST PLACE 2,2,SOUTH PLACE 4,1,WEST")}.to_not raise_error
			end
		end
		context "default size" do
			it "set alternative max size" do
				expect{CommandParser.new(5,6).parse("PLACE 5,6,NORTH")}.to_not raise_error
			end
			it "raises an error when x is > than table size" do
				expect{CommandParser.new(5,6).parse("PLACE 6,6,NORTH")}.to raise_error(CommandParserError,/Invalid PLACE instruction : PLACE 6,6,NORTH/)
			end
			it "raises an error when y is > than table size" do
				expect{CommandParser.new(5,6).parse("PLACE 1,7,SOUTH")}.to raise_error(CommandParserError,/Invalid PLACE instruction : PLACE 1,7,SOUTH/)
			end

		end
	end
end