module SteppingPiece
  def moves
    possible_moves = []
    move_diffs.each do |diff|
      move_position = Piece.get_new_position(@position, diff)
      possible_moves << move_position
    end

    possible_moves.select do |move|
      Board.in_bounds?(move) && @board[move].color != self.color
    end

  end

end
