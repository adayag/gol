class Game
  BOARD_SIZE = 30
  def initialize
    @iteration = 0
    @board = Board.new(BOARD_SIZE)
  end

  def print_board
    @board.cells.map do |cell|
      puts cell.join(" ")
    end
  end
end

class Board
  attr_reader :cells

  def initialize(board_size)
    @board_size = board_size
    @cells = Array.new(10) do
      Array.new(10, "0")
    end
  end
end

class Cell
end

# overkill? you betcha
class Printer
end
