require_relative 'src/board'
require_relative 'src/display'
require_relative 'src/human_player'
require_relative 'src/ai_player'

class Game

  attr_accessor :current_player, :board, :player1, :player2

  def initialize(player1, player2)
    @board = Board.new
    @player1 = player1
    @player2 = player2
    @current_player = player1
  end

  def play
    system 'clear'
    until over?
      current_player.play_turn(board)
      switch_player
    end
  end

  private

  def over?
    board.checkmate?(current_player.color)
  end

  def switch_player
    @current_player = (current_player == player1 ? player2 : player1)
  end

  def prompt
    puts 'Welcome to CLI Chess'
    puts 'Would you like to play against the computer?'
    response = ''
    until ['yes', 'no'].include?(response)
      response = gets.chomp
    end
    case response
    when 'yes'
      player2 = AIPlayer.new("Player 2", :black)
    when 'no'
      player2 = HumanPlayer.new("Player 2", :black)
    end
  end

end



if __FILE__ == $PROGRAM_NAME
  system 'clear'
  puts 'Welcome to CLI Chess'
  response = ''
  until ['yes', 'no'].include?(response)
    puts 'Would you like to play against the computer? (yes or no)'
    response = gets.chomp
  end
  case response
  when 'yes'
    player2 = AIPlayer.new("Computer", :black)
  when 'no'
    player2 = HumanPlayer.new("Player 2", :black)
  end
  player1 = HumanPlayer.new("Player 1", :white)
  Game.new(player1, player2).play
end
