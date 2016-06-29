require "./lib/table"
RSpec.describe Table do
	context "a default table" do
  	it "creates a default table" do
  		expect(Table.new().size).to be == Point.new(4,4)
  	end
  end
  context "valid location" do
  	let(:table) {Table.new()} 
  	it "returns true if x point within table size" do
  		point = Point.new(4,0)
  		expect(table.valid_position?(point)).to be_truthy
  	end
  	it "returns true if y point within table size" do
  		point = Point.new(0,4)
  		expect(table.valid_position?(point)).to be_truthy
  	end
  end
  context "invalid location" do
  	let(:table) {Table.new(3,3)} 
  	it "returns true if x point within table size" do
  		point = Point.new(4,0)
  		expect(table.valid_position?(point)).to be_falsey
  	end
  	it "returns true if y point within table size" do
  		point = Point.new(0,4)
  		expect(table.valid_position?(point)).to be_falsey
  	end
  end

end