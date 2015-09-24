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

    def tier_prices
      sets.map { |_, v| v.map(&:price).inject(:+) }
    end

    def best_price
      tier_prices.min
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

      Shop::DISCOUNT_TIERS.downto(1) do |tier|
        tier_sets[tier] = find_sets_for_tier(books.clone, tier)
      end

      tier_sets
    end

    def find_sets_for_tier( books, tier )
      all_sets = []

      until books.empty? do
        result = find_set( books, tier )

        books = result[:remaining]
        all_sets << BookList.new(result[:set])
      end

      all_sets
    end

    def find_set( books, tier = Shop::DISCOUNT_TIERS )
      set       = []
      remaining = []

      books.each do |book|
        if set.include?(book) || set.size >= tier
          remaining << book
        else
          set << book
        end
      end

      { set: set, remaining: remaining }
    end
  end
end

def book_prices( books )
  list = Shop::BookList.new( books )

  list.best_price
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

  it "should choose the best deal with multiple discounts" do
    expect( book_prices([ 1, 1, 2, 2, 3, 3, 4, 5 ]) ).to eq( 51.20 )

    expect( book_prices([
      1, 1, 1, 1, 1,
      2, 2, 2, 2, 2,
      3, 3, 3, 3,
      4, 4, 4, 4, 4,
      5, 5, 5, 5
    ]) ).to eq( 141.2 ) # 3 * (8 * 5 * 0.75) + 2 * (8 * 4 * 0.8)
  end
end
