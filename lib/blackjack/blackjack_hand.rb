class BlackjackHand
  CARDS = [:ace,
           :two,
           :three,
           :four,
           :five,
           :six,
           :seven,
           :eight,
           :nine,
           :ten,
           :jack,
           :queen,
           :king]

  NON_ACE_CARD_VALUES = {
    two: 2,
    three: 3,
    four: 4,
    five: 5,
    six: 6,
    seven: 7,
    eight: 8,
    nine: 9,
    ten: 10,
    jack: 10,
    queen: 10,
    king: 10
  }

  MAX_SCORE_BEFORE_BUST = 21
  ACE_HIGH_SCORE = 11
  ACE_LOW_SCORE = 1

  attr_reader :cards

  def initialize(cards = [])
    @cards = cards
    @standing = false
  end

  def hit
    raise "You're standing" if status == :standing
    raise "You're bust" if status == :bust

    new_card = random_card
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
    total_with_aces
  end

  private

  attr_accessor :standing
  attr_writer :cards

  def bust?
    score > MAX_SCORE_BEFORE_BUST
  end

  def random_card
    CARDS.sample
  end

  def total_without_aces
    cards
      .select { |card| card != :ace }
      .map { |card| NON_ACE_CARD_VALUES[card] }
      .inject(0, :+)
  end

  def total_with_aces
    cards
      .select { |card| card == :ace }
      .inject(total_without_aces) { |total|
        total + ace_score(total)
      }
  end

  def ace_score(total_so_far)
    total_so_far + ACE_HIGH_SCORE > MAX_SCORE_BEFORE_BUST ?
      ACE_LOW_SCORE :
      ACE_HIGH_SCORE
  end
end
