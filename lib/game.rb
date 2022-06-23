class Game
  def initialize
    @iteration = 0
    @board = Array.new(10) do
      Array.new(10, "0")
    end
  end

  def print_board
    @board.map do |cell|
      puts cell.join(" ")
    end
  end
end
