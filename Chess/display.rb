require 'colorize'
require_relative 'board'
require_relative 'cursor'

class Display

  attr_accessor :current_pos

  def initialize(board, current_pos = [4,4], selected_pos = nil)
    @board = board
    @current_pos = current_pos
    @selected_pos = selected_pos
  end

  def get_input(message = nil)
    cursor = Cursor.new(@current_pos, @board)
    until cursor.selected?
      render(message)
      @current_pos = cursor.get_input
      system 'clear'
    end
    @current_pos
  end

  def render(message = nil)
    puts message

    @board.grid.each.with_index do |row, row_idx|
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

  private

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
