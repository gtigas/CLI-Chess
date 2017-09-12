class Piece
  attr_reader :color, :position

  def initialize(position, color, board)
    @position = position
    @color = color
    @board = board
  end

  def change_position(pos)
    @position = pos
  end

  def to_s
    "p"
  end

  def inspect
    "p"
  end
end
