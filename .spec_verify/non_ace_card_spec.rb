require 'blackjack/non_ace_card'

describe NonAceCard do
  describe "possible_scores" do
    it "returns only score in array" do
      expect(described_class.new(:king).possible_scores)
        .to eq([10])
    end
  end
end
