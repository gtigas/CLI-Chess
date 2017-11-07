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
