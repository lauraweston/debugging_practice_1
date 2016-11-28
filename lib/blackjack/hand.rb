require_relative "./card_factory"

class Hand
  attr_reader :cards

  def initialize(cards = [])
    @cards = cards
    @standing = false
  end

  def hit
    raise "You're standing" if status == :standing
    raise "You're bust" if status == :bust

    new_card = CardFactory.random
    cards << new_card
    new_card
  end

  def stand
    self.standing = true
  end

  def status
    return :bust if bust?
    return :standing if standing
    :playing
  end

  def score
    cards.inject(0) do |total, card|
      total + card.score(total, MAX_SCORE_BEFORE_BUST)
    end
  end

  private

  attr_accessor :standing
  attr_writer :cards

  MAX_SCORE_BEFORE_BUST = 21

  def bust?
    score > MAX_SCORE_BEFORE_BUST
  end
end
