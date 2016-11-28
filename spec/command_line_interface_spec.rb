require 'blackjack/command_line_interface'

describe CommandLineInterface do
  let(:stdin) { double(:stdin) }
  let(:stdout) { double(:stdout) }
  let(:blackjack) { double(:blackjack) }
  let(:blackjack_hand) { double(:blackjack_hand) }
  let(:blackjack_class) { double(:blackjack_class,
                                 new: blackjack) }
  let(:blackjack_hand_class) { double(:blackjack_hand_class,
                                      new: blackjack_hand) }

  describe "::new" do
    it "creates a new Blackjack game with three players" do
      allow(stdout).to receive(:puts)
      allow(stdin).to receive(:gets).and_return(3)
      expect(blackjack_hand_class)
        .to receive(:new).exactly(3).times

      described_class.new(stdin,
                          stdout,
                          blackjack_class,
                          blackjack_hand_class)
    end
  end

  describe "playing a game" do
    it "plays turns until there's a winner" do
      allow(stdout).to receive(:puts)
      allow(stdin).to receive(:gets).and_return(1, "stand")
      allow(blackjack)
        .to receive(:winner?).and_return(false, false, true)
      expect(blackjack).to receive(:play_move).exactly(2).times

      command_line_interface = described_class.new(
        stdin,
        stdout,
        blackjack_class,
        blackjack_hand_class)
      command_line_interface.play
    end
  end
end
