require 'numlet'
require 'rubygems'
require 'rspec'

describe Integer do
  it "should still be a number" do
    Integer.new(55).should true
  end
end