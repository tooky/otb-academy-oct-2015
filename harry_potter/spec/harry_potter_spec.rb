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

  def self.find_sets(all)
    return [] if all.empty?

    # [1, 1, 2, 2, 3, 3, 4, 5]

    sets = []

    until all.empty? do
      set_options = find_set(all, verbose: true)

      all = set_options[:remaining]
      sets << set_options[:set]
    end

    sets
  end # find_sets(...)

  def self.find_set(all, verbose: false)
    set = []
    remaining = []

    max_set_size = 4

    all.each do |v|
      if set.include?(v) || set.size >= max_set_size
        remaining << v
      else
        set << v
      end
    end

    if verbose
      { remaining: remaining, set: set }
    else
      set
    end
  end
end # module

def fs(*args)
  ArryPotta::find_set(*args)
end

def book_prices(books)
  total_price ||= 0

  sets = ArryPotta::find_sets(books)

  sets.each do |set|
    price = 0
    discount = 0

    if (set.size > 1)
      # Set of books
      discount = ArryPotta::get_discount(set.size)
      base_price = ArryPotta::BASE_PRICE * set.size
      price = base_price - (base_price * discount)
    else
      # Single book
      price = ArryPotta::BASE_PRICE
    end

    total_price += price
  end

  total_price
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

  it "should cost 29.6 GBP (10% + 8 GBP) to buy 4 books, 3 unique" do
    expect( book_prices([ 1, 2, 3, 3 ]) ).to eq( 29.6 )
  end

  it "should cost 51.20 GBP to buy a bunch of books" do
    expect( book_prices([ 1, 1, 2, 2, 3, 3, 4, 5 ]) ).to eq( 51.20 )
  end
end
