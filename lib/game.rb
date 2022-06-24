require "pry"
class Game
  BOARD_SIZE = 10

  def initialize
    @iteration = 0
    @board = Board.new(BOARD_SIZE)
    @printer = Printer.new
  end

  def print_board
    @printer.print_board(@board)
  end
end

class Board
  attr_reader :board_size, :grid

  def initialize(board_size)
    @board_size = board_size
    @grid = create_grid
  end

  private

  def create_grid
    grid = []

    board_size.times do |y_axis|
      grid << Array.new(board_size) do |x_axis|
        Cell.new(x_axis, y_axis)
      end
    end

    grid
  end
end

class Cell
  def initialize(x_loc, y_loc)
    @x_loc = x_loc
    @y_loc = y_loc
    @alive = false
  end

  def alive?
    @alive != false
  end
end

# overkill? you betcha
class Printer
  def print_board(board)
    board.grid.map do |row|
      row.each do |cell|
        print cell.alive? ? "*" : "0"
        print " "
      end
      puts
    end
    puts
  end
end
