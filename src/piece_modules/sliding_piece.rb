module SlidingPiece

  def moves
    possible_moves = []
    move_dirs.each do |diff|
      new_position = Piece.get_new_position(@position, diff)
      until !Board.in_bounds?(new_position) || @board[new_position].color == self.color
        possible_moves << new_position
        break unless @board[new_position].is_a?(NullPiece)
        new_position = Piece.get_new_position(new_position, diff)
      end
    end
    possible_moves
  end

  def diagnal_dirs
    [[-1, -1], [1, 1], [-1, 1], [1, -1]]
  end

  def vertical_dirs
    [[-1, 0], [1, 0], [0, 1], [0, -1]]
  end

end
