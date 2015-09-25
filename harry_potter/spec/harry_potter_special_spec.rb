require "book"
require "shopping_basket"

RSpec.describe "Harry Potter special" do
  hp_1 = Book.new(111, "Harry Potter and the Philosopher's Stone")
  hp_2 = Book.new(222, "Harry Potter and the Chamber of Secrets")
  hp_3 = Book.new(333, "Harry Potter and the Prisoner of Azkaban")
  hp_4 = Book.new(444, "Harry Potter and the Goblet of Fire")
  hp_5 = Book.new(555, "Harry Potter and the Order of the Phoenix")

  it "applies no discount for baskets containing only 1 book" do
    basket = ShoppingBasket.new([hp_1])
    expect(basket.total).to eq(8)
  end

  it "applies no discount for baskets containing only 1 book title (but multiple books)" do
    basket = ShoppingBasket.new([hp_1, hp_1])
    expect(basket.total).to eq(16)
  end

  it "applies a 5% discount if the basket contains 2 books of different titles" do
    basket = ShoppingBasket.new([hp_1, hp_2])
    expect(basket.total).to eq(15.2)
  end

  it "applies a 10% discount if the basket contains 3 books of different titles" do
    basket = ShoppingBasket.new([hp_1, hp_2, hp_3])
    expect(basket.total).to eq(21.6)
  end

  it "applies a 20% discount if the basket contains 4 books of different titles" do
    basket = ShoppingBasket.new([hp_1, hp_2, hp_3, hp_4])
    expect(basket.total).to eq(25.6)
  end

  it "applies a 25% discount if the basket contains 5 books of different titles" do
    basket = ShoppingBasket.new([hp_1, hp_2, hp_3, hp_4, hp_5])
    expect(basket.total).to eq(30)
  end

  it "does not apply discount to repeat purchases of a single book title" do
    basket = ShoppingBasket.new([
      hp_1, hp_1, hp_1,
      hp_2,
      hp_3
    ])
    expect(basket.total).to eq(37.6)
  end

  it "applies multiple discounts if the basket contains more than 1 repeat purchase" do
    basket = ShoppingBasket.new([
      hp_1, hp_1,
      hp_2, hp_2,
      hp_3, hp_3,
      hp_4,
      hp_5
    ])
    expect(basket.total).to eq(51.2)
  end

  it "applies multiple discounts if the basket contains more than 1 repeat purchase" do
    basket = ShoppingBasket.new([
      hp_1, hp_1, hp_1, hp_1, hp_1,
      hp_2, hp_2, hp_2, hp_2, hp_2,
      hp_3, hp_3, hp_3, hp_3,
      hp_4, hp_4,
      hp_5
    ])
    expect(basket.total).to eq(113.6)
  end

  it "can handle baskets with books in any order" do
    basket = ShoppingBasket.new([
      hp_1, hp_1, hp_1, hp_1, hp_1,
      hp_2, hp_2, hp_2, hp_2, hp_2,
      hp_3, hp_3, hp_3, hp_3,
      hp_4, hp_4,
      hp_5
    ].shuffle)
    expect(basket.total).to eq(113.6)
  end
end
