class StringCalculator

  def initialize(string)
    @string = string
    @delimiter = @string[/^\/\/(.)\n/m, 1]
  end

  def add
    result = @string.split(/[\n,#{@delimiter}]/).inject(0) do |sum, num|
      raise "Negatives not allowed" if num.to_i < 0
      sum += num.to_i
    end
    result
  end

end

RSpec.describe "string_calculator_text" do
  it "returns 0 when an empty string is passed in" do
    expect(StringCalculator.new("").add).to eq(0)
  end

  it "takes a single number as a string and returns that number as an int" do
    expect(StringCalculator.new("1").add).to eq(1)
  end

  it "parses a string for numbers" do
    expect(StringCalculator.new("1,2").add).to eq(3)
  end

  it "handles negative numbers" do
    expect{StringCalculator.new("10, 0, -42").add}.to raise_error("Negatives not allowed")
  end

  it "allows new lines to be a delimiter" do
    expect(StringCalculator.new("1\n2").add).to eq(3)
  end

  it "allows you to configure your own delimiters" do
    expect(StringCalculator.new("//;\n1;2").add).to eq(3)
  end

end
