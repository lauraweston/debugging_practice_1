class Players
  def initialize(hands)
    @hands = hands
  end

  def name(hand)
    hands.find_index(hand)
  end

  private

  attr_reader :hands
end
