require "./lib/inputfiles"


RSpec.describe Inputfiles do
  describe "read input file" do
    context "with no file argument" do
      it "returns missing input file message" do
        expect{Inputfiles.new().read}.to  raise_error(InputfilesError,/Missing input file with list of commands./)
      end
    end
    context "using a parameter instead of a file" do
      it "returns missing input file message" do
        ARGV << "--invalid"
        expect{Inputfiles.new.read}.to  raise_error(/No such file or directory/)
      end
    end
    context "a valid file name" do
      it "retrieves the command line text" do
        filename = './spec/files/commandslist.txt'
        ARGV << filename
        expect(Inputfiles.new.read).to  include("sample text")
      end
      it "retrieves text from multiple files" do
        filename = './spec/files/commandslist.txt'
        ARGV << filename
        filename = './spec/files/commandslist2.txt'
        ARGV << filename
        expect(Inputfiles.new.read).to  include("Line two from example file two")
      end
    end
  end
end