require 'blackjack/card'

describe Card do
  describe "#random" do
    it "picks one of the registered classes" do
      expect(described_class.random).to respond_to(:symbol)
    end
  end

  describe "register and create" do
    let(:card_class_a) { double(:card_class_a) }
    let(:card_class_b) { double(:card_class_b) }

    it "registers two classes and creates specified one" do
      described_class.register_card_creator(:a, card_class_a)
      described_class.register_card_creator(:b, card_class_b)
      expect(card_class_a).to receive(:new)

      described_class.create(:a)
    end
  end
end
