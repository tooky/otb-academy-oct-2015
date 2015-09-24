def dev
  require 'pry'
end

module ArryPotta
  BASE_PRICE = 8

  DISCOUNTS = {
    1 => 0,
    2 => 5,
    3 => 10,
    4 => 20,
    5 => 25,
  }
end

def book_prices(books)
  # Calculate the base price for all books
  books.inject(0) do |sum, book_id|
    sum += ArryPotta::BASE_PRICE
  end
end

RSpec.describe "harry potter" do
  it "should cost 8 GBP for a single book" do
    expect( book_prices([ 1 ]) ).to eq( 8 )
  end

  it "should cost 16 GBP to buy 2 of the same book" do
    # dev;binding.pry
    expect( book_prices([ 1, 1 ]) ).to eq( 16 )
  end
end
