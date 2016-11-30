require_relative "../blackjack/hand"
require_relative "../blackjack/players"
require_relative "../blackjack"

class CommandLineInterface
  def initialize(input,
                 output,
                 blackjack_class=Blackjack,
                 hand_class=Hand,
                 players_class=Players)
    @input = input
    @output = output
    @hand_class = hand_class

    hands = create_hands
    @blackjack = blackjack_class.new(hands)
    @players = players_class.new(hands)
  end

  def play
    until blackjack.game_over?
      card = blackjack.play_move(get_move)
      output.puts card_announcement(card)
    end

    output.puts result_announcement
  end

  private

  attr_reader :input, :output, :blackjack, :players, :hand_class

  def result_announcement
    blackjack.winner ?
      "Player #{players.name(blackjack.winner)} won" :
      "No winner"
  end

  def card_announcement(card)
    output.puts "Dealt #{card.symbol}"
  end

  def create_hands
    get_hand_count.times.collect { hand_class.new }
  end

  def get_hand_count
    loop do
      output.puts "How many players?"
      hand_count = input.gets.to_i
      return hand_count if hand_count > 0
    end
  end

  def get_move
    loop do
      output.puts "Hit or stand?"
      move = input.gets.chomp.to_sym
      return move if blackjack.valid_move?(move)
    end
  end
end
