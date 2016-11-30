require_relative "./card_list"
require_relative "./ace_card"
require_relative "./non_ace_card"

class Hand
  attr_reader :card_list

  def initialize(card_list=CardList.new)
    @card_list = card_list
    @standing = false
  end

  def hit(card_class=Card)
    raise "You're standing" if standing?
    raise "You're bust" if bust?
    card_list.add(card_class.random)
  end

  def stand
    self.standing = true
  end

  def score
    card_list.scores.inject(0) do |total, possible_scores|
      total + best_score(possible_scores, total)
    end
  end

  def standing?
    standing == true
  end

  def bust?
    score > MAX_SCORE_BEFORE_BUST
  end

  private

  def best_score(possible_scores, total_so_far)
    (total_so_far + possible_scores.max <= MAX_SCORE_BEFORE_BUST ?
       possible_scores.max :
       possible_scores.min)
  end

  attr_accessor :standing
  attr_writer :card_list

  MAX_SCORE_BEFORE_BUST = 21
end
