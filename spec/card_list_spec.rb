require 'blackjack/card_list'

describe CardList do
  describe "::initialize" do
    it "initial card list is emtpy" do
      expect(described_class.new.count).to be(0)
    end
  end

  describe "#add" do
    let(:card_1) { double(:card_1) }
    let(:card_2) { double(:card_2) }

    it "stores multiple cards" do
      subject.add(card_1)
      subject.add(card_2)

      expect(subject.to_a).to eq([card_1, card_2])
    end
  end

  describe "#scores" do
    it "returns an empty array when card list empty" do
      expect(described_class.new.scores).to be_empty
    end

    it "returns an array of possible score arrays" do
      subject.add(double(:king, possible_scores: [10]))
      subject.add(double(:three, possible_scores: [3]))
      subject.add(double(:ace, possible_scores: [1, 11]))

      expect(subject.scores).to eq([[10], [3], [1, 11]])
    end
  end
end
