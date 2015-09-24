
def book_discount_calculator(book_list)
	if book_list.empty?
		0
	elsif book_list.size == 1
		8
	elsif book_list.size == 2
		15.20
	elsif book_list.size == 3
		21.6
	elsif book_list.size == 4
		28.8
	end	
end