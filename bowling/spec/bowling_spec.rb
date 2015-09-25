class BowlingScore
    def initialize(rolls)
        @rolls = rolls
        @rolls.each_with_index do |roll, i|
            if roll == 10
                @rolls.insert(i+1, 0)
            end
            #moved from 'score' method to 'initialize' method
            if@rolls.size%2 == 1
                @rolls << 0
            end
        end
    end
    def score 
        #without bonus; the first 10 pairs
        #spaire bonus; the first 10 pairs + [a, 0] or [10, 0]
        #strike bonus; the first 10 pairs + [a, b] or [10, 0] [b, 0] or [10, 0] [10, 0]
        sliced_rolls = @rolls.each_slice(2).to_a
        #initialize the score value as the number of pins knocked down
        score = @rolls.inject(:+)
        sliced_rolls[0..8].each_with_index do |turn, i|
            #strike
            if turn[0] == 10
                score += @rolls[2*i+2] + @rolls[2*i+3]
                  #two continuious strikes
                  if @rolls[2*i+2] == 10
                     score += @rolls[2*i+4]
                  end
            #spare
            elsif turn[0]+turn[1] == 10
                score += @rolls[2*i+2]
            end
        end
        score
    end
end

RSpec.describe "bowling scored" do
    it "returns 0 when you hit no pins" do
        expect(BowlingScore.new([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]).score).to eq(0)
    end
    it "returns the total number of pins knocked down if you don't knock them all down for every frame" do
        expect(BowlingScore.new([1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]).score).to eq(20)
    end
    it "scores a spare correctly" do
        expect(BowlingScore.new([1,9,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]).score).to eq(29)
    end
    it "scores spares correctly" do
        expect(BowlingScore.new([1,9,1,1,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1]).score).to eq(38)
    end
    it "scores a strike correctly" do
        expect(BowlingScore.new([10,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]).score).to eq(30)
    end
    it "scores strikes correctly" do
        expect(BowlingScore.new([10,10,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]).score).to eq(49)
    end
    it "scores a strike and a spare correctly" do
        expect(BowlingScore.new([10,5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]).score).to eq(47)
    end
    it "scores a spare in the last frame correctly" do
        expect(BowlingScore.new([10,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,9,1,2]).score).to eq(40)
    end
    it "scores a strike in the last frame correctly" do
        expect(BowlingScore.new([10,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,10,1,1]).score).to eq(40)
    end
    it "scores a strike in the last frame correctly" do
        expect(BowlingScore.new([10,10,10,10,10,10,10,10,10,10,10,10]).score).to eq(300)
    end
    it "scores a mixed game" do
        rolls = [2,4,5,3,1,6,8,2,0,2,6,4,10,7,3,0,10,6,4,7]
        expect(BowlingScore.new(rolls).score).to eq 116
    end    
end

