require 'blackjack'
require 'blackjack/blackjack_hand'

describe Blackjack do

  describe "#initialize" do
    let(:blackjack_hand) { double(:blackjack_hand) }
    subject { described_class.new([blackjack_hand]) }

    it "can create a game with a player hand" do
      expect(subject.player_hands.count).to be(1)
    end
  end

  describe "#play_move" do
    let(:blackjack_hand) {
      double(:blackjack_hand, status: :playing)
    }
    subject { described_class.new([blackjack_hand]) }

    it "hits for the current player hand" do
      allow(blackjack_hand).to receive(:hit)
      expect(subject.play_move(:hit)).to be(:playing)
    end

    it "stick for the current player hand" do
      allow(blackjack_hand).to receive(:stand)
      expect { subject.play_move(:stand) }.to_not raise_error
    end

    it "raises error if anything but stick or hit called" do
      allow(blackjack_hand).to receive(:moo)
      expect { subject.play_move(:moo) }
        .to raise_error("Invalid move")
    end

    it "reports the player hand state after move made" do
      allow(blackjack_hand).to receive(:hit)
      allow(blackjack_hand).to receive(:status).and_return(:bust)
      expect(subject.play_move(:hit)).to be(:bust)
    end

    it "raises if hand player move raises" do
      allow(blackjack_hand)
        .to receive(:hit).and_raise("Invalid player hand move")
      expect { subject.play_move(:hit) }
        .to raise_error("Invalid player hand move")
    end

    it "raises if already a winner" do
      allow(blackjack_hand).to receive(:hit)
      expect { subject.play_move(:hit) }
        .to raise_error("Game is over")
    end
  end

  describe "#winner" do
    it "returns standing player when no other players" do
      blackjack_hand = double(:blackjack_hand, status: :standing)
      subject = described_class.new([blackjack_hand])
      expect(subject.winner).to be(blackjack_hand)
    end

    it "returns standing player when other players bust" do
      blackjack_hand_1 = double(:blackjack_hand, status: :standing)
      blackjack_hand_2 = double(:blackjack_hand, status: :bust)
      blackjack_hand_3 = double(:blackjack_hand, status: :bust)

      subject = described_class.new([blackjack_hand_1,
                                     blackjack_hand_2,
                                     blackjack_hand_3])
      expect(subject.winner).to be(blackjack_hand_1)
    end
  end
end
