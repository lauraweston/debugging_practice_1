require_relative "blackjack/hand"

class Blackjack
  attr_reader :player_hands

  def initialize(player_hands)
    @player_hands = player_hands
  end

  def self.valid_player_move?(move)
    [:hit, :stand].include?(move)
  end

  def self.valid_player_count?(count)
    count > 0
  end

  def play_move(move)
    raise "Game is over" if winner?
    raise "Invalid move" unless self.class.valid_player_move?(move)

    current_player_hand.send(move)
    current_player_hand.status
  end

  def winner?
    not winner.nil?
  end

  def winner
    return nil if game_still_going?

    @player_hands
      .select { |hand| hand.status == :standing }
      .sort { |hand_1, hand_2| hand_2.score <=> hand_1.score }[0]
  end

  private

  def game_still_going?
    @player_hands.any? { |hand| hand.status == :playing }
  end

  def current_player_hand
    @player_hands[0]
  end
end
