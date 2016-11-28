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
    let(:playing_blackjack_hand) { double(:blackjack_hand,
                                          status: :playing) }

    it "hits for the current player hand" do
      subject = described_class.new([playing_blackjack_hand])
      allow(playing_blackjack_hand).to receive(:hit)
      expect(subject.play_move(:hit)).to be(:playing)
    end

    it "stand for the current player hand" do
      allow(playing_blackjack_hand).to receive(:stand)
      subject = described_class.new([playing_blackjack_hand])
      expect { subject.play_move(:stand) }.to_not raise_error
    end

    it "raises error if anything but stand or hit called" do
      subject = described_class.new([playing_blackjack_hand])
      allow(playing_blackjack_hand).to receive(:moo)
      expect { subject.play_move(:moo) }
        .to raise_error("Invalid move")
    end

    it "reports the player hand state after move made" do
      subject = described_class.new([playing_blackjack_hand])
      allow(playing_blackjack_hand).to receive(:hit)
      allow(playing_blackjack_hand)
        .to receive(:status).and_return(:bust)
      expect(subject.play_move(:hit)).to be(:bust)
    end

    it "raises if hand player move raises" do
      subject = described_class.new([playing_blackjack_hand])
      allow(playing_blackjack_hand)
        .to receive(:hit).and_raise("Invalid player hand move")
      expect { subject.play_move(:hit) }
        .to raise_error("Invalid player hand move")
    end

    it "raises if already a winner" do
      standing_blackjack_hand = double(:blackjack_hand,
                                       status: :standing)
      subject = described_class.new([standing_blackjack_hand])

      allow(standing_blackjack_hand).to receive(:hit)
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
      blackjack_hand_1 = double(:blackjack_hand_1,
                                status: :standing)
      blackjack_hand_2 = double(:blackjack_hand_2,
                                status: :bust)
      blackjack_hand_3 = double(:blackjack_hand_3,
                                status: :bust)

      subject = described_class.new([blackjack_hand_1,
                                     blackjack_hand_2,
                                     blackjack_hand_3])
      expect(subject.winner).to be(blackjack_hand_1)
    end

    it "returns top scoring player" do
      blackjack_hand_1 = double(:blackjack_hand_1,
                                status: :standing,
                                score: 20)
      blackjack_hand_2 = double(:blackjack_hand_2,
                                status: :standing,
                                score: 21)

      subject = described_class.new([blackjack_hand_1,
                                     blackjack_hand_2])
      expect(subject.winner).to be(blackjack_hand_2)
    end

    it "returns no winner when a player still playing" do
      blackjack_hand_1 = double(:blackjack_hand_1,
                                status: :standing,
                                score: 20)
      blackjack_hand_2 = double(:blackjack_hand_2,
                                status: :playing,
                                score: 21)

      subject = described_class.new([blackjack_hand_1,
                                     blackjack_hand_2])
      expect(subject.winner).to be_nil
    end
  end
end
