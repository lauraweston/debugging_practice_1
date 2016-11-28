class Ace
  attr_reader :symbol

  def initialize
    @symbol = :ace
  end

  def score(total_so_far, max_score_before_bust)
    total_so_far + HIGH_SCORE > max_score_before_bust ?
      LOW_SCORE :
      HIGH_SCORE
  end

  private

  HIGH_SCORE = 11
  LOW_SCORE = 1
end
