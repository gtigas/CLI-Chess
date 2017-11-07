require_relative 'board'
require_relative 'display'

class Game

  attr_accessor :current_player, :board, :player1, :player2

  def initialize(player1, player2)
    @board = Board.new
    @player1 = player1
    @player2 = player2
  end

  def play
    @current_player = player1
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
    @current_player = current_player == player1 ? player2 : player1
  end

end

class HumanPlayer

  attr_reader :name, :color

  def initialize(name, color)
    @name = name
    @color = color
  end

  def play_turn(board)
    error_message = nil
    begin
      start_pos = Display.new(board).get_input(self, error_message)
      raise MoveError.new("You cant' select an empty space.") if board[start_pos].is_a?(NullPiece)
      raise MoveError.new("You can't choose the other player's pieces!") if board[start_pos].color != @color
      raise MoveError.new("That piece can't move anywhere") if board[start_pos].valid_moves.empty?
    rescue MoveError => error
      error_message = error.message
      retry
    end
    error_message = nil
    begin
      end_pos = Display.new(board, start_pos, start_pos).get_input(self, error_message)
      board.move_piece(start_pos, end_pos)
    rescue MoveError => error
      error_message = error.message
      retry
    end
  end

end

if __FILE__ == $PROGRAM_NAME
  player1 = HumanPlayer.new("Player 1", :white)
  player2 = HumanPlayer.new("Player 2", :black)
  Game.new(player1, player2).play
end
