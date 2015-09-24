require "./lib/harry_potter.rb"
RSpec.describe "Harry potter book discount" do
	it "returns 0 when a empty array is passed in" do
		expect(book_discount_calculator([])).to eq(0)
	end

	it "returns 8 when 1 book is passed in" do
		expect(book_discount_calculator([1])).to eq(8)
	end

	it "applies a 5% discount when two books are passed in" do
		expect(book_discount_calculator([1,1])).to eq(15.20)
	end

	it "apples a 10% discount when 3 books are passed in" do
		expect(book_discount_calculator([1, 1, 1])).to eq(21.6)
	end
  
end