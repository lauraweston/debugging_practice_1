require 'blackjack/command_line_interface'

describe CommandLineInterface do
  let(:stdin) { double(:stdin) }
  let(:stdout) { double(:stdout) }
  let(:blackjack) { double(:blackjack) }
  let(:hand) { double(:hand) }
  let(:blackjack_class) { double(:blackjack_class,
                                 valid_move?: true,
                                 new: blackjack) }
  let(:hand_class) { double(:hand_class, new: hand) }

  describe "::new" do
    it "creates a new Blackjack game with three players" do
      allow(stdout).to receive(:puts)
      allow(stdin).to receive(:gets).and_return(3)
      expect(hand_class)
        .to receive(:new).exactly(3).times

      described_class.new(stdin,
                          stdout,
                          blackjack_class,
                          hand_class)
    end
  end

  describe "playing a game" do
    it "plays turns until there's a winner" do
      allow(stdout).to receive(:puts)
      allow(stdin).to receive(:gets).and_return(1, "stand")
      allow(blackjack)
        .to receive(:winner).and_return(nil, nil, :winner)
      expect(blackjack).to receive(:play_move).exactly(2).times

      command_line_interface = described_class.new(
        stdin,
        stdout,
        blackjack_class,
        hand_class)
      command_line_interface.play
    end
  end
end
