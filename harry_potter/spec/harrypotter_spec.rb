=begin
Harry Potter Special
To try and encourage more sales of the 5 different Harry Potter books they sell,
a bookshop has decided to offer discounts of multiple-book purchases.

One copy of any of the five books costs 8 GBP.

If, however, you buy two different books, you get a 5% discount on those two books.
If you buy 3 different books, you get a 10% discount.
If you buy 4 different books, you get a 20% discount.
If you go the whole hog, and buy all 5, you get a huge 25% discount.

Note that if you buy, say, four books, of which 3 are different titles, 
- you get a 10% discount on the 3 that form part of a set, 
- but the fourth book still costs 8 GBP.

Your mission is to write a piece of code 
- to calculate the price of any conceivable shopping basket (containing only Harry Potter books),
- giving as big a discount as possible.

#Example
For example, how much does this basket of books cost?
- 2 copies of the first book
- 2 copies of the second book 
- 2 copies of the third book
- 1 copy of the fourth book 
- 1 copy of the fifth book
Answer: 51.20 GBP
=end

class HPspecial
    @@discount = {2=>0.95, 3=>0.9, 4=>0.8, 5=>0.75}
    def initialize(purchase)
        @purchase = purchase
        @purchase_hash = Hash.new(0)
        @purchase_list = [0, 0, 0, 0, 0, 0]
        @purchase.each do |p|
            @purchase_hash[p] += 1
            @purchase_list[p] += 1
        end
    end
    #Defines which method to use to calculate the final price
    def basket
        return self.basket_greedy_modified
    end
    #basket_greedy
    #Calculates the final price in a greedy way
    #Discounts will be applied in an order of discount rates
    def basket_greedy
        run = true
        special_price = 0
        while run
            count = @purchase_list.count{|x| x > 0}
            if count > 1
                special_price += 8*count*@@discount[count]
                @purchase_list = @purchase_list.map{|item| item -= 1 }        
            else
                @purchase_list.each do |p|
                    if p > 0
                        special_price += p*8
                    end
                end
                run = false
            end
        end
        special_price
    end
    #basket_greedy
    #Basically same as 'basket_greedy', but it prefers 'two 'four-different-books' discount
    def try_discount(count)
        if count == 5
            try_hash = @purchase_hash.clone
            purchase_sorted = try_hash.sort_by{|ep,n| n}.reverse
            (0..3).each do |here|
                try_hash[purchase_sorted[here][0]] -= 1
            end
            count = try_hash.values.count{|x| x > 0}
            if count >= 4
                purchase_sorted = try_hash.sort_by{|ep,n| n}.reverse
                (0..3).each do |here|
                    try_hash[purchase_sorted[here][0]] -= 1
                end
                @purchase_hash = try_hash
                return true
            end
        end
        return false
    end
    def basket_greedy_modified
        run = true
        special_price = 0
        while run
            count = @purchase_hash.values.count{|x| x > 0}
            if count > 1
                #two 'four-diff-books' discounts
                try = self.try_discount(count)
                if try
                    special_price += 2*8*4*@@discount[4]
                else
                    special_price += 8*count*@@discount[count]
                    @purchase_hash.each{|k,v| @purchase_hash[k] -= 1 }
                end        
            else
                remains = @purchase_hash.values.inject(:+)
                special_price += 8*remains if remains
                run = false
            end
        end
        special_price
    end
    def basket_tree
    
    end
end

        
RSpec.describe "#Harry Potter Special#" do
    #0 book
    it "returns 0 if you don't buy any books" do
        expect(HPspecial.new([]).basket).to eq(0)
    end
    #1 book
    it "returns 8 if you buy only one book" do
        expect(HPspecial.new([1]).basket).to eq(8)
    end
    #2 books
    it "returns 8*2*0.95 if you buy two same books" do
        expect(HPspecial.new([1,2]).basket).to eq(8*2*0.95)
    end
    it "returns 8*2 if you buy two different books" do
        expect(HPspecial.new([1,1]).basket).to eq(8*2)
    end
    #3 books
    it "returns 8*3 if you buy three same books" do
        expect(HPspecial.new([1,1,1]).basket).to eq(8*3)
    end
    it "returns 8*2*0.95 + 8 if you buy two same books and one other book" do
        expect(HPspecial.new([1,1,2]).basket).to eq(8*2*0.95 + 8)
    end
    it "returns 8*3*0.9 if you buy three different books" do
        expect(HPspecial.new([1,2,3]).basket).to eq(8*3*0.9)
    end
    #4 books
    it "returns 8*4 if you buy four same books" do
        expect(HPspecial.new([1,1,1,1]).basket).to eq(8*4)
    end 
    it "returns 8*2 + 8*2*0.95 if you buy three same books and one other book" do
        expect(HPspecial.new([1,1,1,2]).basket).to eq(8*2 + 8*2*0.95)
    end
    it "returns 8*2*0.95 + 8*2*0.95 if you two same books and two other same  books" do
        expect(HPspecial.new([1,1,2,2]).basket).to eq(2*8*2*0.95)
    end
    it "returns 8*3*0.9 + 8 if you buy three different books" do
        expect(HPspecial.new([1,1,2,3]).basket).to eq(8*3*0.9 + 8)
    end
    it "returns 8*4*0.8 if you buy three different books" do
        expect(HPspecial.new([1,2,3,4]).basket).to eq(8*4*0.8)
    end
    #given test scenario
    it "given scenario" do
        expect(HPspecial.new([1,1,2,2,3,3,4,5]).basket).to eq(51.2)
    end
end
