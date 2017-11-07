require 'colorize'
require_relative 'board'
require_relative 'cursor'

class Display

  attr_accessor :current_pos
  attr_reader :board

  def initialize(board, current_pos = [4,4], selected_pos = nil)
    @board = board
    @current_pos = current_pos
    @selected_pos = selected_pos
  end

  def get_input(current_player, message)
    cursor = Cursor.new(current_pos, board)
    until cursor.selected?
      render(current_player, message)
      @current_pos = cursor.get_input
      system 'clear'
    end
    current_pos
  end

  def render(current_player , last_message  = nil)
    puts "Controls: Use the arrow keys to move the cursor \nand use the space bar to select a position \n \n"
    if board.in_check?(current_player.color)
      puts "CHECK! Your turn, #{current_player.name} (#{current_player.color})!"
    else
      puts "Your turn, #{current_player.name} (#{current_player.color})!"
    end

    print_board

    puts last_message if last_message
  end

  private

  def print_board
    board.grid.each.with_index do |row, row_idx|
      row.each.with_index do |piece, col_idx|
        if [row_idx, col_idx] == @current_pos
          print " #{piece.to_s.colorize(:red)} ".on_green
        elsif [row_idx, col_idx]  == @selected_pos
          print " #{piece.to_s.colorize(:blue)} ".on_cyan
        else
          print " #{piece} "
            .colorize(:background => choose_bg_color(row_idx, col_idx))
        end
      end
      puts ""
    end
  end

  def choose_bg_color(row, col)
    if col == 0 && row % 2 == 0
      :yellow
    elsif col == 0 && row % 2 != 0
      :white
    elsif col % 2 == 0 && row % 2 != 0
      :white
    elsif col % 2 != 0 && row % 2 == 0
      :white
    else
      :yellow
    end
  end
end
