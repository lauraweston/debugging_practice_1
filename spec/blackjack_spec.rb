require 'blackjack'
require 'blackjack/hand'

describe Blackjack do
  describe "#initialize" do
    let(:hand) { double(:hand) }

    it "can create a game with a player hand" do
      expect { described_class.new([hand]) }.to_not raise_error
    end
  end

  describe "#play_move" do
    it "hits the current player hand" do
      hand = double(:hand, standing?: false, bust?: false)
      subject = described_class.new([hand])
      expect(hand).to receive(:hit)
      subject.play_move(:hit)
    end

    it "stands the current player hand" do
      hand = double(:hand, standing?: false, bust?: false)
      subject = described_class.new([hand])
      expect(hand).to receive(:stand)

      subject.play_move(:stand)
    end

    it "raises error if anything but stand or hit called" do
      hand = double(:hand, standing?: false, bust?: false)
      subject = described_class.new([hand])
      allow(hand).to receive(:moo)

      expect { subject.play_move(:moo) }
        .to raise_error("Invalid move")
    end

    it "raises if already a winner" do
      hand = double(:hand, standing?: true, bust?: false)
      subject = described_class.new([hand])

      expect { subject.play_move(:hit) }
        .to raise_error("Game is over")
    end

    describe "choosing the current player" do
      it "chooses player with fewest cards" do
        hand_1 = double(:hand_1, standing?: false, bust?: false,
                        card_list: [:card])
        hand_2 = double(:hand_2, standing?: false, bust?: false,
                        card_list: [])
        subject = described_class.new([hand_1, hand_2])

        expect(hand_2).to receive(:hit)
        subject.play_move(:hit)
      end

      it "chooses non-standing player with fewest cards" do
        hand_1 = double(:hand_1, standing?: false, bust?: false,
                        card_list: [:card])
        hand_2 = double(:hand_2, standing?: true, bust?: false,
                        card_list: [])
        subject = described_class.new([hand_1, hand_2])

        expect(hand_1).to receive(:hit)
        subject.play_move(:hit)
      end

      it "chooses non-bust player with fewest cards" do
        hand_1 = double(:hand_1, standing?: false, bust?: false,
                        card_list: [:card])
        hand_2 = double(:hand_2, standing?: false, bust?: true,
                        card_list: [])
        subject = described_class.new([hand_1, hand_2])

        expect(hand_1).to receive(:hit)
        subject.play_move(:hit)
      end
    end
  end

  describe "#winner" do
    it "returns standing player when no other players" do
      hand = double(:hand, standing?: true, bust?: false)
      subject = described_class.new([hand])
      expect(subject.winner).to be(hand)
    end

    it "returns standing player when other players bust" do
      hand_1 = double(:hand_1, standing?: true, bust?: false)
      hand_2 = double(:hand_2, standing?: true, bust?: true)
      hand_3 = double(:hand_3, standing?: true, bust?: true)

      subject = described_class.new([hand_1, hand_2, hand_3])
      expect(subject.winner).to be(hand_1)
    end

    it "returns top scoring player" do
      hand_1 = double(:hand_1, standing?: true, bust?: false,
                      score: 20)
      hand_2 = double(:hand_2, standing?: true, bust?: false,
                      score: 21)

      subject = described_class.new([hand_1, hand_2])
      expect(subject.winner).to be(hand_2)
    end

    it "returns no winner when a player still playing" do
      hand_1 = double(:hand_1, standing?: true, bust?: false,
                      score: 20)
      hand_2 = double(:hand_2, standing?: false, bust?: false,
                      score: 21)

      subject = described_class.new([hand_1, hand_2])
      expect(subject.winner).to be_nil
    end
  end
end
