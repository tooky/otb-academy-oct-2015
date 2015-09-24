RSpec.describe "Harry Potter special" do
  before(:each) do
    @basket = ShoppingBasket.new
  end

	it "applies no discount for baskets containing only 1 book title" do
		@basket.add_items([hp_1, hp_1, hp_1])
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
		@basket.add_items([hp_1, hp_1, hp_2, hp_3])
		expect(@basket.total).to eq(29.6)
	end

	it "does not apply discounts to repeat purchases of multiple book titles" do
		@basket.add_items([hp_1, hp_1, hp_2, hp_2, hp_3, hp_3, hp_4, hp_5])
		expect(@basket.total).to eq(54)
	end
end