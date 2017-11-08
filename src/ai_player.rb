require 'byebug'

class AIPlayer
  attr_reader :name, :color, :board

  def initialize(name, color)
    @name = name
    @color = color
  end

  def play_turn(board)
    @board = board
    get_weighted_move
  end

  private

  def own_pieces
    board.all_pieces(color).shuffle
  end

  def evauluate_board(given_board)
    opponent_value = given_board.all_pieces(:white).inject(0) do |total, piece|
      total + PIECE_VALUES[piece.class.to_s]
    end
    player_value = given_board.all_pieces(:black).inject(0) do |total, piece|
      total + PIECE_VALUES[piece.class.to_s]
    end

    player_value - opponent_value
  end

  def get_weighted_move
    best_move = nil
    best_board_value = -5000
    piece_pos = nil

    own_pieces.each do |piece|
      piece_possible_moves = piece.valid_moves
      piece_possible_moves.each do |move|
        duped_board = board.dup
        duped_board.move_piece!(piece.position, move)

        board_value = evauluate_board(duped_board)
        if board_value > best_board_value
          best_board_value = board_value
          piece_pos = piece.position
          best_move = move
        end
      end
    end


    board.move_piece(piece_pos, best_move)
  end

  PIECE_VALUES = {
    "NullPiece" => 0,
    "Pawn" => 10,
    "Knight" => 30,
    "Bishop" => 30,
    "Rook" => 50,
    "Queen" => 90,
    "King" => 900
  }
end
