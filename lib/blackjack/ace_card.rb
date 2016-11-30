require_relative "./card"

class AceCard < Card
  attr_reader :symbol

  def initialize(symbol)
    @symbol = symbol
  end

  def possible_scores
    [LOW_SCORE, HIGH_SCORE]
  end

  private

  Card.register_card_creator(:ace, self)

  LOW_SCORE = 1
  HIGH_SCORE = 11
end
