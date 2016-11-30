require 'blackjack/ace_card'

describe AceCard do
  describe "possible_scores" do
    it "returns low and high scores" do
      expect(described_class.new(:ace).possible_scores)
        .to eq([1, 11])
    end
  end
end
