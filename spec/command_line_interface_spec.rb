require 'blackjack/command_line_interface'

describe CommandLineInterface do
  let(:stdin) { double(:stdin) }
  let(:stdout) { double(:stdout) }
  let(:game) { double(:game) }

  describe "::new" do
    it "creates a new Blackjack game with three players" do
      allow(stdout).to receive(:puts)
      allow(stdin).to receive(:gets).and_return(3)
      expect(game).to receive(:add_players)

      described_class.new(stdin, stdout, game)
    end
  end

  describe "playing a game" do
    it "plays turns until there's a winner" do
      king = double(:king, symbol: king)

      allow(stdout).to receive(:puts)
      allow(stdin).to receive(:gets).and_return(1, "stand")

      allow(game).to receive(:add_players)
      allow(game)
        .to receive(:over?).and_return(false, false, true)
      allow(game).to receive(:winner?).and_return(true)
      allow(game).to receive(:winner_name).and_return(:winner)

      expect(game).to receive(:play_move).exactly(2).times
                       .and_return(king)

      command_line_interface = described_class.new(
        stdin,
        stdout,
        game)
      command_line_interface.play
    end
  end
end
