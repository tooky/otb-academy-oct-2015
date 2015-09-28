def totals(books)
  price = 0
  multiplier = 1
  bul = books.uniq.length

  multiplier = 0.95 if bul == 2
  multiplier = 0.9 if bul == 3
  multiplier = 0.8 if bul == 4
  multiplier = 0.75 if bul == 5

  if books.length == 1
    price = books.length * 8
  elsif books.length == 2 && bul == 2
    price = books.length * 8 * multiplier
  elsif books.length == 3 && bul == 3
    price = books.length * 8 * multiplier
  elsif books.length == 4 && bul == 4
    price = books.length * 8 * multiplier
  elsif books.length == 5 && bul == 5
    price = books.length * 8 * multiplier
  elsif books.length > bul && bul == 1
    price = books.length * 8
  elsif books.length > bul && bul == 2
    price = (books.length - bul) * 8 + (books.length - (books.length - bul)) * 8 * 0.95 #if 
  end

  #stack_dup(books)

end

def stack_dup(books)
  var = 1
  alt_arr = []
  while var <= books.length
    if books.at(var-1) == books.at(var)
      alt_arr << books.at(var)
      books.delete_at(var)
      var += 1
    else
      var += 1
    end
  end
  alt_arr
end

RSpec.describe "Harry" do 

  it "shows the price of a single book as £8" do
    books = [1]
    price = totals(books)
    expect(price).to eq 8
  end

  it "shows the price of two different books as £15.2 (5% discount)" do
    books = [1,2]
    price = totals(books)
    expect(price).to eq 15.2
  end

  it "shows the price of three different books as £21.6 (10% discount)" do
    books = [1,2,3]
    price = totals(books)
    expect(price).to eq 21.6
  end

  it "shows the price of four different books as £25.6 (20% discount)" do
    books = [1,2,3,4]
    price = totals(books)
    expect(price).to eq 25.6
  end

  it "shows the price of five different books as £30 (25% discount)" do
    books = [1,2,3,4,5]
    price = totals(books)
    expect(price).to eq 30
  end

  it "shows the price of three of the same books as £24 (no discount)" do
    books = [3,3,3]
    price = totals(books)
    expect(price).to eq 24
  end

  it "shows the price of 1, 1, 2 as 23.2 (5% discount)" do
    books = [1,1,2]
    price = totals(books)
    expect(price).to eq 23.2
  end

  it "shows the price of 1, 1, 2, 2 as 30.4 (5% discount)" do
    books = [1,1,2,2]
    price = totals(books)
    expect(price).to eq 30.4
  end

  it "shows the price of 1, 1, 2, 2, 2 as whatever" do
    books = [1,1,2,2,2]
    price = totals(books)
    expect(price).to eq 35
  end



end