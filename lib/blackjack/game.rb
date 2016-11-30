require_relative "../blackjack/hand"
require_relative "../blackjack/players"
require_relative "../blackjack"

class Game
  def initialize(blackjack_class=Blackjack,
                 hand_class=Hand,
                 players_class=Players)
    @blackjack_class = blackjack_class
    @hand_class = hand_class
    @players_class = players_class
  end

  def add_players(player_count)
    hands = player_count.times.collect { hand_class.new }
    @blackjack = blackjack_class.new(hands)
    @players = players_class.new(hands)
  end

  def play_move(move)
    blackjack.play_move(move)
  end

  def over?
    blackjack.game_over?
  end

  def winner?
    !!blackjack.winner
  end

  def winner_name
    players.name(blackjack.winner)
  end

  private

  attr_reader :blackjack, :players,
              :hand_class, :blackjack_class, :players_class
end
