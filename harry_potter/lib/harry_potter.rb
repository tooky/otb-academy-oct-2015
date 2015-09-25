DISCOUNT = { 1 => 1, 2 => 0.95, 3 => 0.9, 4 => 0.8, 5 => 0.75}


def book_discount_calculator(books_list)
	@price = 0
	return 0 if books_list.empty?
	@books_list = books_list
	book_count = @books_list.max
	puts @books_list
	puts " book count is #{book_count}"
	i = 0

	book_count.times do
		@books_list.delete(0)
		puts @books_list.inspect
		if special_case
			puts "in"
			@books_list = special_discount
		else
			puts "in h"
			discounter
		end
		puts @books_list.inspect
		i =+ 1
	end
	@price
end

def discounter
	puts "in di"
	puts @books_list.inspect
	@price += (8 * books_count) * DISCOUNT[books_count]
	puts "price is #{@price}"
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
puts book_discount_calculator([5, 5, 4, 5, 4])






