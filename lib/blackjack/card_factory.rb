require_relative "./ace"
require_relative "./non_ace_card"

class CardFactory
  def self.create(symbol)
    symbol == :ace ? Ace.new : NonAceCard.new(symbol)
  end

  def self.random
    self.create(CARD_SYMBOLS.sample)
  end

  private

  CARD_SYMBOLS = [
    :ace, :two, :three, :four, :five,
    :six, :seven, :eight, :nine, :ten,
    :jack, :queen, :king
  ]
end
