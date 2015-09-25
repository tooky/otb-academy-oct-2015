class HPspecial
    #Discount rates
    @@discount = {2=>0.95, 3=>0.9, 4=>0.8, 5=>0.75}
    #Initializes the instance and builds a hash to store the input
    def initialize(purchase)
        @purchase = purchase
        @purchase_hash = Hash.new(0)
        @purchase.each do |p|
            @purchase_hash[p] += 1
        end
        #@special_price = 0
        #used by basktet_three
        @minp = 8*purchase.length
    end
    #Defines which method to use to calculate the final price
    #a. basket_greedy
    #b. basket_greedy_modified
    #c. basket_tree
    def basket
        #self.basket_greedy
        #self.basket_greedy_modified
        self.basket_tree(@purchase_hash, [], 0)
        return @minp
    end
    #Accessory methods
    #a. uniq
    #b. proceed
    #c. remains
    #returns the number of unique series
    def uniq(h=@purchase_hash)
        return h.values.count{|x| x > 0}
    end
    #decreases the number of each series by one, if there is any
    def proceed
        @purchase_hash.each{|k,v| @purchase_hash[k] -= 1 if v > 0}
    end
    #returns the number of remaining books that no discounts will be applied to
    def remains(h=@purchase_hash)
        return h.values.select{|c| c > 0}.inject(0, :+)
    end
    #basket_greedy
    # -calculates the final price in a greedy way
    # -discounts will be applied in an order of discount rates
    def basket_greedy
        @minp = 0
        run = true
        while run
            uniq = self.uniq
            if uniq > 1
                @minp += 8*uniq*@@discount[uniq]
                self.proceed        
            else
                @minp += 8*self.remains
                run = false
            end
        end
    end
    #basket_greedy_modified
    # -basically same as 'basket_greedy'
    # -but it prefers 'two 'four-different-books' discount
    def basket_greedy_modified
        @minp = 0
        run = true
        while run
            uniq = self.uniq
            if uniq > 1
                #try two 'four-diffrent-books' discounts
                if uniq == 5 && self.try_discount
                    @minp += 2*8*4*@@discount[4]
                else
                    @minp += 8*uniq*@@discount[uniq]
                    self.proceed
                end        
            else
                @minp += 8*self.remains
                run = false
            end
        end
    end
    #try_discount
    #- will be called by basket_greedy_modified 
    def try_discount
        #try with a copy of the original data
        try_hash = @purchase_hash.clone
        #inner method to proceed 'four-different-books' discount
        try_four_discount = lambda {
            purchase_sorted = try_hash.sort_by{|ep,n| n}.reverse
            (0..3).each{|here| try_hash[purchase_sorted[here][0]] -= 1}
        }
        #try the first 'fout-different-books' discount
        try_four_discount.call
        uniq = self.uniq(try_hash)
        #if the second 'four-different-books' discount is possible,
        #it'll replace 'five-different-books' discount
        if uniq >= 4
            try_four_discount.call
            #if successful, the original data will be updated to 'try_hash' 
            @purchase_hash = try_hash
            return true
        end
        return false
    end
    #basket_tree
    #- updates the minimum price while trying every possible discount
    def basket_tree(input, result, price)
        uniq = self.uniq(input)
        #if there are no more uniq series
        if uniq < 2
            #add '-1' to the trajectory
            result.push(-1)
            #add the price of the remains to the final price
            price += 8*self.remains(input)
            #update the minimum price
            @minp = [price, @minp].min
            return result
        #For each possible discount, it tries calculating its final price
        elsif price > @minp
            return result
        else
            (2..uniq).each do |i|
                #tries the next node with a copy of the parent node
                h = Hash.new
                h = input.clone
                #tries the next price with a copy of thr price of the parent node
                price_a = price + i*8*@@discount[i]
                #recursively tries the next nodes
                self.basket_tree(self.next_node(h,i), result.push(i), price_a)
            end
        end
        return result 
    end
    #next_node
    #- will be called by basket_tree 
    def next_node(input, i)
        input_sorted = input.sort_by{|ep,n| n}.reverse
        (0..i-1).each{|here| input[input_sorted[here][0]] -= 1}
        return input
    end
    #EndMethodDef
end
#EndClassHPspecial

#TEST cases        
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
    it "returns 8*2*0.95 + 8*2*0.95 if you two same books and two other same books" do
        expect(HPspecial.new([1,1,2,2]).basket).to eq(2*8*2*0.95)
    end
    it "returns 8*3*0.9 + 8 if you buy three different books and one other book" do
        expect(HPspecial.new([1,1,2,3]).basket).to eq(8*3*0.9 + 8)
    end
    it "returns 8*4*0.8 if you buy four different books" do
        expect(HPspecial.new([1,2,3,4]).basket).to eq(8*4*0.8)
    end
    #given test cases
    it "test case by Steve" do
        expect(HPspecial.new([1,1,2,2,3,3,4,5]).basket).to eq(51.2)
    end
    it "test case by Michael" do
        expect(HPspecial.new([1,1,1,1,1,2,2,2,2,2,3,3,3,3,4,4,4,4,4,5,5,5,5]).basket).to eq(141.2)
    end
    #EndTestCase
#EndRSpec test
end
#EndFile
