class Piece
  attr_reader :color, :position
  attr_accessor :board

  SYMBOLS = {
    :King => '♚',
    :Queen => '♛',
    :Rook => '♜',
    :Bishop => '♝',
    :Knight => '♞',
    :Pawn => '♟',
    :NullPiece => ' '
  }



  def initialize(position, color, board)
    @position = position
    @color = color
    @board = board
  end

  def change_position(pos)
    @position = pos
  end

  def valid_moves
    moves.reject { |move| move_into_check?(move) }
  end

  def move_into_check?(end_pos)
    check_board = @board.dup
    check_board.move_piece!(@position, end_pos)
    check_board.in_check?(@color)
  end

  def duplicate
    self.class.new(@position, @color, nil)
  end


  def to_s
    if self.color == :black
      SYMBOLS[self.class.name.to_sym].colorize(self.color)
    else
      SYMBOLS[self.class.name.to_sym].colorize(:light_white)
    end

  end

  def inspect
    "p"
  end

  def self.get_new_position(previous_pos, diff)
    [previous_pos[0] + diff[0], previous_pos[1] + diff[1]]
  end

end
