def book_discount_calculator(book_list)
	result = 0
	while book_list.size != 0
		book_list.delete(0)
		result += discount(book_list)
		book_list.map! { |book| book - 1}
	end
	result
end


def discount(book_list)
	puts "In the discounter"
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
	 elsif book_list.size == 5
	 	30
	 end
end

puts book_discount_calculator([2,2,2,1,1])