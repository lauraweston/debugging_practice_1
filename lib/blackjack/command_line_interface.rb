require_relative "../blackjack"

class CommandLineInterface
  def initialize(input,
                 output,
                 blackjack_class,
                 hand_class)
    @input = input
    @output = output
    @hand_class = hand_class
    @blackjack = blackjack_class.new(create_players)
  end

  def play
    until blackjack.winner
      blackjack.play_move(get_player_move)
    end
  end

  private

  attr_reader :input, :output, :blackjack, :hand_class

  def create_players
    get_player_count.times.collect do
      hand_class.new
    end
  end

  def get_player_count
    player_count = 0
    until Blackjack.valid_player_count?(player_count)
      output.puts "How many players?"
      player_count = input.gets.to_i
    end

    player_count
  end

  def get_player_move
    player_move = nil
    until Blackjack.valid_player_move?(player_move)
      output.puts "Hit or stand?"
      player_move = input.gets.to_sym
    end

    player_move
  end
end
