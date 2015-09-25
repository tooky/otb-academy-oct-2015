class Book
  def initialize(isbn, title)
    @isbn, @title = isbn, title
  end

  def to_s
    @isbn
  end

  def price
    8
  end
end
