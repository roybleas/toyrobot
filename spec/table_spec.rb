require "./lib/table"
RSpec.describe Table do
	context "a default table" do
  	it "creates a default table" do
  		expect(Table.new()).to be_kind_of(Table)
  	end
  end
end