require 'blackjack/hand'
require 'blackjack/card_factory'

def create_cards(cards)
  cards.map { |symbol| CardFactory.create(symbol) }
end

describe Hand do
  describe "#initialize" do
    subject { described_class.new }

    it "has no cards when first created" do
      expect(subject.cards).to be_empty
    end
  end

  describe "#hit" do
    before :each do
      srand(0)
    end

    after :each do
      srand
    end

    it "deals a random card" do
      subject = described_class.new
      expect(subject.hit.symbol).to eq(:king)
    end

    it "stores the dealt card" do
      subject.hit
      expect(subject.cards[0].symbol).to eq(:king)
    end

    it "stores multiple dealt cards" do
      subject.hit
      subject.hit

      expect(subject.cards.map(&:symbol)).to eq([:king, :six])
    end

    it "raises if hit when standing" do
      subject.stand
      expect { subject.hit }.to raise_error "You're standing"
    end

    it "raises if hit when bust" do
      subject = described_class.new(
        create_cards([:king, :king, :king]))
      expect { subject.hit }.to raise_error "You're bust"
    end
  end

  describe "#stand" do
    it "sets status to :standing" do
      subject.stand
      expect(subject.status).to be(:standing)
    end
  end

  describe "#score" do
    it "reports score for hand without aces" do
      subject = described_class.new(
        create_cards([:king, :queen]))
      expect(subject.score).to be(20)
    end

    it "reports min score for hand with ace that prevents bust" do
      subject = described_class.new(
        create_cards([:king, :queen, :ace]))
      expect(subject.score).to be(21)
    end

    it "reports minimum score for bust hand with aces" do
      subject = described_class.new(
        create_cards([:king, :queen, :ace, :ace]))
      expect(subject.score).to be(22)
    end

    it "reports maximum score for unbust hand with ace" do
      subject = described_class.new(
        create_cards([:ace, :king]))
      expect(subject.score).to be(21)
    end

    it "reports unbust score for hand with many aces" do
      subject = described_class.new(
        create_cards([:ace, :ace, :ace, :ace, :ace]))
      expect(subject.score).to be(15)
    end
  end

  describe "#status" do
    it "initially reports playing" do
      subject = described_class.new
      expect(subject.status).to be(:playing)
    end

    it "reports standing when player stands" do
      subject = described_class.new
      subject.stand
      expect(subject.status).to be(:standing)
    end

    it "reports bust if player goes over 21" do
      subject = described_class.new(
        create_cards([:king, :queen, :six]))
      expect(subject.status).to be(:bust)
    end
  end
end
