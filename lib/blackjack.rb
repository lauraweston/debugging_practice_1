require_relative "blackjack/blackjack_hand"

class Blackjack
  attr_reader :player_hands

  def initialize(player_hands)
    @player_hands = player_hands
  end

  def play_move(move)
    raise "Game is over" if winner?
    raise "Invalid move" unless [:hit, :stand].include?(move)

    current_player_hand.send(move)
    current_player_hand.status
  end

  def winner?
    not winner.nil?
  end

  def winner
    @player_hands.select { |hand|
      hand.status == :standing
    }.sort { |hand_1, hand_2|
      hand_2.score <=> hand_1.score
    }
  end

  private

  def current_player_hand
    @player_hands[0]
  end
end
