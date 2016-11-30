require 'blackjack/game'

describe Game do
  let (:blackjack) { double(:blackjack) }
  let (:blackjack_class) { double(:blackjack_class,
                                  new: blackjack) }
  let (:hand_class) { double(:hand_class) }
  let (:players) { double(:players) }
  let (:players_class) { double(:players_class, new: players) }

  describe "::initialize" do
    it "creates an instance with game classes" do
      expect(described_class.new(blackjack_class,
                                 hand_class,
                                 players_class))
        .to be_instance_of(Game)
    end
  end

  describe "#add_players" do
    it "adds players to game" do
      expect(blackjack_class).to receive(:new)
      expect(players_class).to receive(:new)
      expect(hand_class).to receive(:new).exactly(3).times

      described_class.new(blackjack_class,
                          hand_class,
                          players_class).add_players(3)
    end
  end

  describe "#play_move" do
    it "delegates playing move to blackjack game" do
      allow(hand_class).to receive(:new)
      expect(blackjack).to receive(:play_move).with(:hit)

      game = described_class.new(blackjack_class,
                                 hand_class,
                                 players_class)
      game.add_players(1)
      game.play_move(:hit)
    end
  end

  describe "#over?" do
    it "delegates game_over enquiry to blackjack game" do
      allow(hand_class).to receive(:new)
      expect(blackjack).to receive(:game_over?)

      game = described_class.new(blackjack_class,
                                 hand_class,
                                 players_class)
      game.add_players(1)
      game.over?
    end
  end

  describe "#winner?" do
    it "returns true when blackjack winner not nil" do
      winner = double(:winner)
      allow(hand_class).to receive(:new)
      expect(blackjack).to receive(:winner).and_return(winner)

      game = described_class.new(blackjack_class,
                                 hand_class,
                                 players_class)
      game.add_players(1)
      expect(game.winner?).to be(true)
    end

    it "returns false when blackjack winner nil" do
      winner = nil
      allow(hand_class).to receive(:new)
      expect(blackjack).to receive(:winner).and_return(winner)

      game = described_class.new(blackjack_class,
                                 hand_class,
                                 players_class)
      game.add_players(1)
      expect(game.winner?).to be(false)
    end
  end

  describe "#winner_name" do
    it "delegates winner name to blackjack and players" do
      allow(hand_class).to receive(:new)
      expect(blackjack).to receive(:winner)
      expect(players).to receive(:name)

      game = described_class.new(blackjack_class,
                                 hand_class,
                                 players_class)
      game.add_players(1)
      game.winner_name
    end
  end

end
