def price(books)
	sum = 0 # if no books are bought and else used later on
	prices = [0, 8, 15.2, 21.6, 25.6, 30] # 0%, 0%, 5%, 10%, 20%, 25% discounts

  # Create an array with 5 elements 
  # If there is no book then the element is 0 
  # [] => [0, 0, 0, 0, 0]
  # [0, 0, 1] => [2, 1, 0, 0, 0]
  # [0, 1, 2] => [1, 1, 1, 0, 0]
  # [0, 1, 1, 2, 2, 4] => [1, 2, 2, 0, 1]
  # [0, 1, 1, 2, 3, 4] => [1, 2, 1, 1, 1]
  # [1, 1, 1, 1, 2, 2, 2, 3, 4, 4, 5] => [4, 3, 1, 2, 1]

  basket = books.sort.inject(Array.new(5) {0}) do |hash, element|
    if hash[element] == 0
      hash[element] = 1
    else
      hash[element] += 1
    end 
    hash
  end

  # loop until basket is empty
	until basket.reduce(:+) == 0
		set = 0

    # loop over the [2, 2, 1, 1, 1] (example) and if the element exists
    # subtract it and add it to the 'set'
		5.times do |index|
			unless basket[index] == 0
				basket[index] -= 1
				set += 1
			end
		end

    # in case of corner case, return doubled value of 5th element of prices array  
		if basket.reduce(:+) == 3 and set == 5
      return sum += prices[4] * 2 
    else
		  sum += prices[set]
    end
	end

	sum.round(2) # to avoid 64.00000001 etc
end


RSpec.describe "Harry" do 

  it "shows the price of no books as £0" do
    books = []
    price = price(books)
    expect(price).to eq 0.00
  end

  it "shows the price of a single book as £8 (no discount)" do
    books = [0]
    price = price(books)
    expect(price).to eq 8.00
  end

  it "shows the price of two of the same books as £16 (no discount)" do
    books = [2,2]
    price = price(books)
    expect(price).to eq 16.00
  end

  it "shows the price of three of the same books as £24 (no discount)" do
    books = [2,2,2]
    price = price(books)
    expect(price).to eq 24.00
  end

  it "shows the price of ten of the same books as £80 (no discount)" do
    books = [3,3,3,3,3,3,3,3,3,3]
    price = price(books)
    expect(price).to eq 80.00
  end

  it "shows the price of two different books as £15.2 (5% discount)" do
    books = [0,1]
    price = price(books)
    expect(price).to eq 15.20
  end

  it "shows the price of 1, 1, 2 as 23.2 (5% discount)" do
    books = [0,0,1]
    price = price(books)
    expect(price).to eq 23.20
  end

  it "shows the price of three different books as £21.6 (10% discount)" do
    books = [0,1,2]
    price = price(books)
    expect(price).to eq 21.60
  end

  it "shows the price of four different books as £25.6 (20% discount)" do
    books = [0,1,2,3]
    price = price(books)
    expect(price).to eq 25.60
  end

  it "shows the price of five different books as £30 (25% discount)" do
    books = [0,1,2,3,4]
    price = price(books)
    expect(price).to eq 30.00
  end

  it "shows the price of 1, 1, 2, 2 as 30.4 (5% discount)" do
    books = [0,0,1,1]
    price = price(books)
    expect(price).to eq 30.40
  end

  it "shows the price of 1, 1, 1, 2, 2, 3, 3, 3 as 64.8 (5% discount)" do
    books = [0,0,0,1,1,1,2,2,2]
    price = price(books)
    expect(price).to eq 64.80
  end

  it "shows the price of 1, 1, 2, 2, 2 as whatever" do
    books = [0,0,1,1,1]
    price = price(books)
    expect(price).to eq 38.40
  end

  it "shows the price of 1,1,2,2,3,3,4,5 as 51.20" do
    books = [0,0,1,1,2,2,3,4]
    price = price(books)
    expect(price).to eq 51.20
  end


end