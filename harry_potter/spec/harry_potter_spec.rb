def dev
  require 'pry'
end

#
#   def self.clamp(v, min, max)
#     (v <= min) ? min : (v >= max) ? max : v
#   end
#
#   def self.get_discount(books)
#     books = clamp(books, 0, DISCOUNTS.size)
#
#     DISCOUNTS[books] * 0.01
#   end
#
#   def self.find_sets(all)
#     return [] if all.empty?
#
#     max_sets = DISCOUNTS.size
#     all_sets = Hash.new([])
#
#     # max_sets.downto(1) do |i|
#     #   all_sets[i] = find_set(all, max_set_size: max_sets)
#     # end
#     #
#     # dev;binding.pry
#
#     # dev;binding.pry
#
#     max_sets.downto(1) do |i|
#       sets = []
#       local_all = all
#
#       until local_all.size <= 1 do
#         set_options = find_set(all, max_set_size: i, verbose: true)
#
#         local_all = set_options[:remaining]
#         sets << set_options[:set]
#       end
#
#       all_sets[i] = (sets << local_all)
#     end
#
#     all_sets
#   end # find_sets(...)
#
#   def self.find_set_price(set)
#     price = Shop::BASE_PRICE * set.size
#
#     if set.size > 1
#       discount = Shop::get_discount
#       price -= (price * discount)
#     end
#
#     price
#   end
#
#   def self.find_best_price(sets)
#     dev;binding.pry
#   end
#
#   def self.find_set(all, max_set_size: 1, verbose: false)
#     return all if all.size <= 1
#
#     set = []
#     remaining = []
#
#     all.each do |v|
#       if set.include?(v) || set.size >= max_set_size
#         remaining << v
#       else
#         set << v
#       end
#     end
#
#     if verbose
#       { remaining: remaining, set: set }
#     else
#       set
#     end
#   end
# end # module
#
# def fs(*args)
#   Shop::find_set(*args)
# end
#
# def book_prices(books)
#   total_price ||= 0
#
#   sets = Shop::find_sets(books)
#   best_price = Shop::find_best_price(sets)
#
#   sets.each do |set|
#     price = 0
#     discount = 0
#
#     if (set.size > 1)
#
#     else
#       # Single book
#       price = Shop::BASE_PRICE
#     end
#
#     total_price += price
#   end
#
#   total_price
# end

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
end

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

  def cheapest_price
    sets.map { |_, v| v.map(&:price).inject(:+) }.min
  end

  def price
    base_price = Shop::BASE_PRICE * @books.size

    base_price - (base_price * discount)
  end

  def set?
    @books.uniq.size == @books.size
  end

  def sets
    @sets ||= find_all_sets(@books)
  end

  def discount
    return 0 unless set?

    return Shop::DISCOUNTS[@books.size] * 0.01
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

def book_prices( books )
  list = BookList.new( books )

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
