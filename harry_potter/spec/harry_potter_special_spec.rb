class Book
  attr_reader :isbn

  def initialize(isbn, title)
    @isbn = isbn
    @title = title
  end

  def price
    8
  end
end

class ShoppingBasket
  def add_items(new_items)
    basket.concat(new_items)
  end

  def total
    discountable_items_total + non_discountable_items_total
  end

  private

  def basket
    @basket ||= []
  end

  def discountable_items
    items = basket.uniq { |item| item.isbn }
    if items.size > 1
      items
    else
      []
    end
  end

  def non_discountable_items
    basket.reject { |item| discountable_items.include?(item) }
  end

  def discountable_items_total
    items_total(discountable_items) * discount_rate(discountable_items.size)
  end

  def non_discountable_items_total
    items_total(non_discountable_items)
  end

  def items_total(items)
    items.inject(0) do |running_total, item|
      running_total + item.price
    end
  end

  def discount_rate(count)
    (100 - discount_rates.fetch(count, 0)) / 100.0
  end

  def discount_rates
    {
      2 => 5,
      3 => 10,
      4 => 20,
      5 => 25,
    }
  end
end

hp_1 = Book.new(111, "Harry Potter and the Philosopher's Stone")
hp_2 = Book.new(222, "Harry Potter and the Chamber of Secrets")
hp_3 = Book.new(333, "Harry Potter and the Prisoner of Azkaban")
hp_4 = Book.new(444, "Harry Potter and the Goblet of Fire")
hp_5 = Book.new(555, "Harry Potter and the Order of the Phoenix")

# helper for generating book copys
def book_copy(book)
  book.clone
end

RSpec.describe "Harry Potter special" do
  before(:each) do
    @basket = ShoppingBasket.new
  end

  it "applies no discount for baskets containing only 1 book title" do
    @basket.add_items([hp_1, hp_1.clone, hp_1.clone])
    expect(@basket.total).to eq(24)
  end

  it "applies a 5% discount to the first books with said titles if the basket contains 2 different book titles" do
    @basket.add_items([hp_1, hp_2])
    expect(@basket.total).to eq(15.2)
  end

  it "applies a 10% discount to the first books with said titles if the basket contains 3 different book titles" do
    @basket.add_items([hp_1, hp_2, hp_3])
    expect(@basket.total).to eq(21.6)
  end

  it "applies a 20% discount to the first books with said titles if the basket contains 4 different book titles" do
    @basket.add_items([hp_1, hp_2, hp_3, hp_4])
    expect(@basket.total).to eq(25.6)
  end

  it "applies a 25% discount to the first books with said titles if the basket contains 5 different book titles" do
    @basket.add_items([hp_1, hp_2, hp_3, hp_4, hp_5])
    expect(@basket.total).to eq(30)
  end

  it "does not apply discounts to repeat purchases of the same book title" do
    @basket.add_items([hp_1, hp_1.clone, hp_2, hp_3])
    expect(@basket.total).to eq(29.6)
  end

  it "does not apply discounts to repeat purchases of multiple book titles" do
    @basket.add_items([hp_1, hp_1.clone, hp_2, hp_2.clone, hp_3, hp_3.clone, hp_4, hp_5])
    expect(@basket.total).to eq(51.2)
  end
end
