# These tests are to verify that the test is completed correctly Don't
# change them.  If they are changed then your submission will be
# marked as incorrect.

require 'spec_helper'

describe Calculator do
  let(:calculator) { described_class.new }

  describe "#add" do
    it "adds two numbers" do
      expect(calculator.add(2, 3)).to equal(5)
    end
  end

  describe "#subtract" do
    it "subtracts two numbers" do
      expect(calculator.subtract(2, 3)).to equal(-1)
    end
  end

  describe "#multiply" do
    it "multiplies two numbers" do
      expect(calculator.multiply(2, 3)).to equal(6)
    end
  end

  describe "#divide" do
    it "divides two numbers" do
      expect(calculator.divide(2, 2)).to equal(1)
    end
  end
end
