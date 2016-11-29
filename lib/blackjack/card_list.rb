class CardList
  include Enumerable

  def initialize
    @cards = []
  end

  def add(card)
    cards << card
    card
  end

  def each(&block)
    cards.each(&block)
  end

  def scores
    self.map(&:possible_scores).map(&:sort)
  end

  private

  attr_accessor :cards
end
