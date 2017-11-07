require_relative 'board'
require_relative 'display'
require_relative 'human_player'
require_relative 'ai_player'
require 'byebug'

class Game

  attr_accessor :current_player, :board, :player1, :player2

  def initialize(player1, player2)
    @board = Board.new
    @player1 = player1
    @player2 = player2
    @current_player = player1
  end

  def play
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

end



if __FILE__ == $PROGRAM_NAME
  player1 = HumanPlayer.new("Player 1", :white)
  player2 = AIPlayer.new("Player 2", :black)
  Game.new(player1, player2).play
end
