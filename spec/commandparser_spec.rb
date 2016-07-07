require "./lib/commandparser"


RSpec.describe CommandParser do
  describe "reads a string of instructions" do
    let(:commandParser) {CommandParser.new()} 
    context "when no instructions" do
      it "creates an empty array from an empty input string" do
        expect(commandParser.parse("")).to be_empty
      end
      it "ignores white space " do
        expect(commandParser.parse("   \n  ")).to be_empty
      end
    end
    context " with known instructions" do
      it "includes MOVE" do
        expect(commandParser.parse("MOVE")).to eq ["MOVE"]
      end
      it "includes REPORT" do
        expect(commandParser.parse("REPORT ")).to eq ["REPORT"]
      end     
      it "includes LEFT" do
        expect(commandParser.parse("LEFT ")).to eq ["LEFT"]
      end
      it "includes RIGHT" do
        expect(commandParser.parse("RIGHT ")).to eq ["RIGHT"]
      end
      it "includes PLACE d,d,f" do
        expect(commandParser.parse("PLACE 0,1,WEST ")).to eq ["PLACE 0,1,WEST"]
      end
    end
    context "with multiple known instructions" do
      it "of the same instruction" do
        expect(commandParser.parse("MOVE MOVE MOVE")).to eq ["MOVE","MOVE", "MOVE"]
      end
      it "combined" do
        expect(commandParser.parse("PLACE 2,4,SOUTH MOVE RIGHT LEFT REPORT")).to eq ["PLACE 2,4,SOUTH", "MOVE", "RIGHT", "LEFT", "REPORT"]
      end
      it "allows multiple whitespace between instructions" do
        expect(commandParser.parse("MOVE   MOVE       MOVE MOVE")).to eq ["MOVE", "MOVE", "MOVE", "MOVE"]
      end
      it "allows multiple whitespace between all types of instructions" do
        expect(commandParser.parse("MOVE   LEFT       RIGHT  REPORT  PLACE 1,2,WEST   ")).to eq ["MOVE", "LEFT", "RIGHT", "REPORT", "PLACE 1,2,WEST"]
      end     
    end
    context "unknown instructions" do
      it "raises an error" do
        expect{commandParser.parse("unknown-instruction")}.to raise_error(CommandParserError,/Invalid instruction at 0 : unknown/)
      end
    end
    context "Invalid instructions" do
      it "raises an error and shows the position of the first unknown word" do
        expect{commandParser.parse("LEFT RIGHT invalid MOVE")}.to raise_error(CommandParserError,/Invalid instruction at 11 : invalid/)
      end
    end
    context "Invalid PLACE instructions" do
      it "raises an error when facing is unknown" do
        expect{commandParser.parse("PLACE 0,0,WRONG")}.to raise_error(CommandParserError,/Invalid PLACE instruction : PLACE 0,0,WRONG/)
      end
      it "raises an error when x is not numeric" do
        expect{commandParser.parse("PLACE x,0,NORTH")}.to raise_error(CommandParserError,/Invalid instruction at 0 : PLACE/)
      end
      it "raises an error when y is not numeric" do
        expect{commandParser.parse("PLACE 1,y,SOUTH")}.to raise_error(CommandParserError,/Invalid instruction at 0 : PLACE/)
      end
      it "raises an error when facing is not all upper case" do
        expect{commandParser.parse("PLACE 1,2,South")}.to raise_error(CommandParserError,/Invalid PLACE instruction : PLACE 1,2,South/)
      end
    end
    context "Valid PLACE instructions" do
      it "does not raise an error when facing is NORTH, EAST, SOUTH, WEST" do
        expect{commandParser.parse("PLACE 0,4,NORTH PLACE 1,3,EAST PLACE 2,2,SOUTH PLACE 4,1,WEST")}.to_not raise_error
      end
    end
    context "comment lines" do
      it "ignores line starting with #" do
        expect(commandParser.parse("# ")).to be_empty
      end
      it "returns commands after a comment line" do
        expect(commandParser.parse(" # test line \nMOVE REPORT ")).to eq ["MOVE", "REPORT"]
      end
      it "ignores comment lines between instructions" do
        expect(commandParser.parse("MOVE \n # test line \nLEFT REPORT ")).to eq ["MOVE","LEFT", "REPORT"]
      end
      it "ignores comments before all instructions" do
        expect(commandParser.parse("# test line 1 \n PLACE 0,1,EAST MOVE \n # test line 2\nLEFT \n REPORT \n RIGHT \n # Last comment")).to eq ["PLACE 0,1,EAST", "MOVE","LEFT", "REPORT" , "RIGHT"]
      end
      it "ignores multiple comment lines before instructions" do
        expect(commandParser.parse("# test line 1 \n# test line 1 \n PLACE 0,1,EAST MOVE \n # test line 2\nLEFT \n REPORT \n RIGHT \n # Last comment")).to eq ["PLACE 0,1,EAST", "MOVE","LEFT", "REPORT" , "RIGHT"]
      end
      
    end
  end
end