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
        @special_price = 0
    end
    #Defines which method to use to calculate the final price
    #a. basket_greedy
    #b. basket_greedy_modified
    #c. basket_tree
    def basket
        self.basket_greedy
        return @special_price
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
    def remains
        return @purchase_hash.values.select{|c| c > 0}.inject(0, :+)
    end
    #basket_greedy
    # -calculates the final price in a greedy way
    # -discounts will be applied in an order of discount rates
    def basket_greedy
        run = true
        while run
            uniq = self.uniq
            if uniq > 1
                @special_price += 8*uniq*@@discount[uniq]
                self.proceed        
            else
                @special_price += 8*self.remains
                run = false
            end
        end
    end
    #basket_greedy_modified
    # -basically same as 'basket_greedy'
    # -but it prefers 'two 'four-different-books' discount
    def basket_greedy_modified
        run = true
        while run
            uniq = self.uniq
            if uniq > 1
                #try two 'four-diffrent-books' discounts
                if uniq == 5 && self.try_discount
                    @special_price += 2*8*4*@@discount[4]
                else
                    @special_price += 8*uniq*@@discount[uniq]
                    self.proceed
                end        
            else
                @special_price += 8*self.remains
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
        #it'll overdo 'five-different-books' discount
        if uniq >= 4
            try_four_discount.call
            #if successful, the original data will be updated to 'try_hash' 
            @purchase_hash = try_hash
            return true
        end
        return false
    end
    #basket_tree
    #- tries every possible discount
    #- returns the minimum price 
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
