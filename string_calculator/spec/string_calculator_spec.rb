class StringCalculator

  def initialize(string)
    @string = string
    @delimiter = @string[/^\/\/(.+)\n/m, 1].to_s
    @delimiters = @delimiter.tr('[', '').split(']')
  end

  def add
    negatives = []
    result = @string.split(/[\n,#{Regexp.escape(@delimiters.join)}]/).inject(0) do |sum, num|
      negatives << num.strip if num.to_i < 0
      sum += num.to_i if num.to_i <= 1000
      sum
    end
    if negatives.size > 0
      raise "Negatives not allowed (#{negatives.join(", ")})"
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
    calc = StringCalculator.new("10, 0, -42")

    expect{calc.add}.to raise_error(/Negatives not allowed/)
    expect{calc.add}.to raise_error("Negatives not allowed (-42)")
  end

  it "handles multiple negative numbers" do
    expect{ StringCalculator.new("-10, -90, -80, 8" ).add}.to raise_error(
    "Negatives not allowed (-10, -90, -80)")
  end

  it "allows new lines to be a delimiter" do
    expect(StringCalculator.new("1\n2").add).to eq(3)
  end

  it "allows you to configure your own delimiters" do
    expect(StringCalculator.new("//;\n1;2").add).to eq(3)
  end

  it "ignores numbers that are greater than 1000" do
    expect(StringCalculator.new("2,1001").add).to eq(2)
  end

  it "allows delimiters of any length" do
    expect(StringCalculator.new("//[***]\n1***2***3").add).to eq(6)
  end

  it "allows multiple delimiters" do
    expect(StringCalculator.new("//[*][%]\n1*2%3").add).to eq(6)
  end

end
