require_relative "../blackjack/game"

class CommandLineInterface
  def initialize(input, output, game)
    @input = input
    @output = output
    @game = game
    @game.add_players(get_player_count)
    play
  end

  def play
    until game.over?
      play_move
    end

    output.puts describe_result
  end

  private

  attr_reader :input, :output, :game

  def play_move
    move = get_move
    card = game.play_move(move)

    if move == :hit
      output.puts describe_card(card)
    end
  end

  def describe_result
    game.winner? ?
      "Player #{game.winner_name} won" :
      "No winner"
  end

  def describe_card(card)
    "Dealt #{card.symbol}"
  end

  def get_player_count
    output.puts "How many players?"
    input.gets.to_i
  end

  def get_move
    output.puts "Hit or stand?"
    input.gets.chomp.to_sym
  end
end
