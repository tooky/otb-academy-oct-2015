DISCOUNT = { 1 => 1, 2 => 0.95, 3 => 0.9, 4 => 0.8, 5 => 0.75}


def book_discount_calculator(books_list)
	@price = 0
	return 0 if books_list.empty?
	@books_list = books_list
	book_count = @books_list.max

	book_count.times do
		@books_list.delete(0)
		if special_case
			@books_list = special_discount
		else
			discounter
		end
	end
	@price
end

def discounter
	puts @books_list.inspect
	@price += (8 * books_count) * DISCOUNT[books_count]
	@books_list.map! { |book| book -= 1}
end


def books_count
	@books_list.size
end

def total_books
	
	@books_list.inject(0) { |sum, num| sum += num}
end

def special_case
	(total_books % 4) == 0 && (total_books % 5) != 0 && @books_list.size >= 4
end

def special_discount
	books_list = @books_list.each_with_index.collect { |book,index| index < 4 ? book -= 1 : book }
	@price += (4 * 8) * 0.8 
	return books_list
end
puts book_discount_calculator([5,5,4,2,1])






