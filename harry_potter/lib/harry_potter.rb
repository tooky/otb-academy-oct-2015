
def book_discount_calculator(book_list)
	if book_list.empty?
		0
	elsif book_list.size == 1
		if book_list[0] > 1
			return book_list[0] * 8
		end
		8
	elsif book_list.size == 2
		15.20
	elsif book_list.size == 3
		21.6
	elsif book_list.size == 4
		28.8
	elsif book_list.size == 5
		30
	end
end

puts book_discount_calculator([2])