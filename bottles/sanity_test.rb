gem 'rspec'
require 'rspec/autorun'
class Sanity < Struct.new(:answer)
end
RSpec.describe "sanity test" do
  it "works" do
    expect( Sanity.new(42).answer ).to eq( 42 )
  end
end
