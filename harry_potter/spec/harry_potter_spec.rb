require "./lib/harry_potter.rb"
RSpec.describe "Harry potter book discount" do
	it "returns 0 when a empty array is passed in" do
		expect(book_discount_calculator([])).to eq(0)
	end

	it "returns 8 when 1 book is passed in" do
		expect(book_discount_calculator([1])).to eq(8.0)
	end

	it "applies a 5% discount when two books are passed in" do
		expect(book_discount_calculator([1,1])).to eq(15.20)
	end

	it "apples a 10% discount when 3 books are passed in" do
		expect(book_discount_calculator([1, 1, 1])).to eq(21.6)
	end

	it "applies a 20% discount when 4 books are passed in" do
		expect(book_discount_calculator([1,1,1,1])).to eq(25.6)
	end

	it "applies a 25% discount when 4 books are passed in" do
		expect(book_discount_calculator([1,1,1,1,1])).to eq(30.0) 
	end

	it "returns normal price when two of the same books are passed in" do
		expect(book_discount_calculator([2])).to eq(16)
	end

	it "applies discount and adds normal price to 2 same books and 1 different" do
		expect(book_discount_calculator([2,1])).to eq(23.20)
	end

	it "applies best discount when 2 sets of 4 unique books are in the order" do
		expect(book_discount_calculator([2,2,2,1,1])).to eq(51.20)
	end

	it "costs £141.2 when [5,5,4,5,4] is passed in" do
		expect(book_discount_calculator([5,5,4,5,4])).to eq(141.2)
	end


  
end