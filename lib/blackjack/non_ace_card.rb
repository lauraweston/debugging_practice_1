class NonAceCard
  attr_reader :symbol

  def initialize(symbol)
    @symbol = symbol
  end

  def score(_, _)
    SCORES[symbol]
  end

  private

  SCORES = {
    two: 2, three: 3, four: 4, five: 5, six: 6,
    seven: 7, eight: 8, nine: 9, ten: 10, jack: 10,
    queen: 10, king: 10
  }
end
