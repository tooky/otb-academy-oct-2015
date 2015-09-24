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

  def self.clamp(v, min, max)
    (v <= min) ? min : (v >= max) ? max : v
  end

  def self.get_discount(books)
    books = clamp(books, 0, DISCOUNTS.size)

    DISCOUNTS[books] * 0.01
  end
end

def book_prices(books)
  total_price ||= 0
  unique_books = books.uniq

  discount = ArryPotta::get_discount(unique_books.size)
  total_price = books.size * ArryPotta::BASE_PRICE

  total_price - (total_price * discount)
end

RSpec.describe "harry potter" do
  it "should cost 8 GBP for a single book" do
    expect( book_prices([ 1 ]) ).to eq( 8 )
  end

  it "should cost 16 GBP to buy 2 of the same book" do
    # dev;binding.pry
    expect( book_prices([ 1, 1 ]) ).to eq( 16 )
  end

  it "should cost 15.20 GBP (5%) to buy 2 different books" do
    expect( book_prices([ 1, 2 ]) ).to eq( 15.20 )
  end

  it "should cost 21.6 GBP (10%) to buy 3 different books" do
    expect( book_prices([ 1, 2, 3 ]) ).to eq( 21.6 )
  end

  it "should cost 51.20 GBP to buy a bunch of books" do
    # dev;binding.pry
    expect( book_prices([ 1, 1, 2, 2, 3, 3, 4, 5 ]) ).to eq( 51.20 )
  end
end
