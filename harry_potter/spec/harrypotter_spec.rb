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
        return self.basket_tree
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
                remains = @purchase_hash.values.inject(:+)
                special_price += 8*remains if remains
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
