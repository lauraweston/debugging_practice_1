require_relative "../blackjack/hand"
require_relative "../blackjack"

class CommandLineInterface
  def initialize(input,
                 output,
                 blackjack_class=Blackjack,
                 hand_class=Hand)
    @input = input
    @output = output
    @hand_class = hand_class
    @blackjack = blackjack_class.new(create_hands)
  end

  def play
    until blackjack.winner
      blackjack.play_move(get_move)
    end
  end

  private

  attr_reader :input, :output, :blackjack, :hand_class

  def create_hands
    get_hand_count.times.collect do
      hand_class.new
    end
  end

  def get_hand_count
    hand_count = 0
    until hand_count > 0
      output.puts "How many players?"
      hand_count = input.gets.to_i
    end

    hand_count
  end

  def get_move
    move = nil
    until Blackjack.valid_move?(move)
      output.puts "Hit or stand?"
      move = input.gets.to_sym
    end

    move
  end
end
