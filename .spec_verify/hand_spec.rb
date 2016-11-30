require 'blackjack/hand'

describe Hand do
  describe "#initialize" do
    let(:card_list) { double(:card_list) }
    subject { described_class.new(card_list) }

    it "takes and stores card list" do
      expect(subject.card_list).to eq(card_list)
    end
  end

  describe "#hit" do
    let(:card_class) { double(:card_class) }

    before :each do
      srand(0)
    end

    after :each do
      srand
    end

    it "adds a random card to the card list" do
      card_list = double(:card_list, scores: [])
      subject = described_class.new(card_list)

      expect(card_list).to receive(:add)
      expect(card_class).to receive(:random)

      expect(subject.hit(card_class))
    end

    it "raises if hit when standing" do
      card_list = double(:card_list, scores: [])
      subject = described_class.new(card_list)
      subject.stand

      expect { subject.hit }.to raise_error "You're standing"
    end

    it "raises if hit when bust" do
      card_list = double(:card_list, scores: [[10], [10], [10]])
      subject = described_class.new(card_list)
      expect { subject.hit }.to raise_error "You're bust"
    end
  end

  describe "#stand" do
    it "sets to standing" do
      card_list = double(:card_list, scores: [])
      subject = described_class.new(card_list)

      subject.stand

      expect(subject.standing?).to be(true)
    end
  end

  describe "#score" do
    it "reports score for hand without aces" do
      card_list = double(:card_list, scores: [[10], [10]])
      subject = described_class.new(card_list)
      expect(subject.score).to be(20)
    end

    it "reports min score for hand with ace that prevents bust" do
      card_list = double(:card_list,
                         scores: [[10], [10], [1, 11]])
      subject = described_class.new(card_list)
      expect(subject.score).to be(21)
    end

    it "reports minimum score for bust hand with aces" do
      card_list = double(:card_list,
                         scores: [[10], [10], [1, 11], [1, 11]])
      subject = described_class.new(card_list)
      expect(subject.score).to be(22)
    end

    it "reports maximum score for unbust hand with ace" do
      card_list = double(:card_list,
                         scores: [[1, 11], [10]])
      subject = described_class.new(card_list)

      expect(subject.score).to be(21)
    end

    it "reports unbust score for hand with many aces" do
      card_list = double(:card_list, scores: [[1, 11],
                                              [1, 11],
                                              [1, 11],
                                              [1, 11],
                                              [1, 11]])
      subject = described_class.new(card_list)
      expect(subject.score).to be(15)
    end
  end
end
