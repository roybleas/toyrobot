require "./lib/location"


RSpec.describe Point do
	context "area test" do
		let(:point) {Point.new(4,4)}
		context "outside area" do
			it "returns false when x > point" do
				expect(point.within_area?(Point.new(5,0))).to be_falsey
			end
			it "returns false when x < 0" do
				expect(point.within_area?(Point.new(-1,0))).to be_falsey
			end
			it "returns false when y > point" do
				expect(point.within_area?(Point.new(0,5))).to be_falsey
			end
			it "returns false when y < 0" do
				expect(point.within_area?(Point.new(0,-10))).to be_falsey
			end
		end
		context "inside area" do
			it "returns false when x <= point" do
				expect(point.within_area?(Point.new(4,0))).to be_truthy
			end
			it "returns true when x >= 0" do
				expect(point.within_area?(Point.new(0,0))).to be_truthy
			end
			it "returns true when y <= point" do
				expect(point.within_area?(Point.new(0,4))).to be_truthy
			end
			it "returns true when y >= 0" do
				expect(point.within_area?(Point.new(0,0))).to be_truthy
			end
			it "returns true when valid x and y" do
				expect(point.within_area?(Point.new(0,0))).to be_truthy
			end

		end
	end 
end