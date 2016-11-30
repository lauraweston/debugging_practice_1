require 'blackjack/players'

describe Players do
  let (:hands) { double(:hands, find_index: 1) }

  describe "::initialize" do
    it "creates an instance with some hands" do
      expect(described_class.new(hands)).to be_instance_of(Players)
    end
  end

  describe "#name" do
    let (:hand) { double(:hand) }

    it "returs the index (name) of the passed hand" do
      expect(hands).to receive(:find_index).with(hand)

      expect { described_class.new(hands).name(hand) }
        .to_not raise_error
    end
  end
end
