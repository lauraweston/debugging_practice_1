require 'spec_helper'

describe Calculator do
  before :each do
    let(:calculator) { described_class.new }
  end

  describe "#add" do
    it "adds two numbers" do
      assert_equal 5, @calculator.add(2, 3)
    end
  end

  describe "#subtract" do
    it "subtracts two numbers" do
      assert_equal 5, @calculator.subtract(2, 3)
    end
  end

  describe "#multiply" do
    it "multiplies two numbers" do
      assert_equal 5, @calculator.multiply(2, 3)
    end
  end

  describe "#divide" do
    it "divides two numbers" do
      assert_equal 5, @calculator.divide(2, 3)
    end
  end
end
