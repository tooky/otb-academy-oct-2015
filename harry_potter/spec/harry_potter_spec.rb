module Shop
  BASE_PRICE = 8

  DISCOUNTS = {
    1 => 0,
    2 => 5,
    3 => 10,
    4 => 20,
    5 => 25,
  }

  DISCOUNT_TIERS = DISCOUNTS.size

  class Book
    attr_accessor :price

    def initialize(price)
      @price = price
    end

    def to_s
      "<Book price='#{@price}'>"
    end
  end

  class BookList
    attr_accessor :books
    attr_reader   :sets

    def initialize( books = [] )
      @books = books
    end

    def method_missing(method, *args, &block)
      if @books.respond_to? method
        return @books.send(method, *args, &block)
      end

      super
    end

    def price
      base_price = Shop::BASE_PRICE * @books.size

      base_price - (base_price * discount)
    end

    def cheapest_price
      sets.map { |_, v| v.map(&:price).inject(:+) }.min
    end

    def sets
      @sets ||= find_all_sets(@books)
    end

    def set?
      @books.uniq.size == @books.size
    end

    def discount
      if set? then Shop::DISCOUNTS[@books.size] * 0.01 else 0 end
    end

    def to_s
      "<BookList books='#{@books}'>"
    end

    private

    def find_all_sets( books )
      tier_sets = Hash.new(BookList.new())

      Shop::DISCOUNT_TIERS.downto(1) do |max_set_size|
        books_clone = books.clone
        all_sets    = []

        until books_clone.empty? do
          # Find nearest set, store remaining books
          set       = []
          remaining = []

          books_clone.each do |book|
            if set.include?(book) || set.size >= max_set_size
              remaining << book
            else
              set << book
            end
          end

          books_clone = remaining
          all_sets << BookList.new(set)
        end

        tier_sets[max_set_size] = all_sets
      end

      tier_sets
    end
  end
end

def book_prices( books )
  list = Shop::BookList.new( books )

  list.cheapest_price
end

RSpec.describe "harry potter" do
  it "should cost 8 GBP for a single book" do
    expect( book_prices([ 1 ]) ).to eq( 8 )
  end

  it "should cost 16 GBP to buy 2 of the same book" do
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
