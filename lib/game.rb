require "pry"

class Game
  BOARD_SIZE = 50
  MAX_ITERATIONS = 100

  def initialize
    @iteration = 1
    @board = Board.new(BOARD_SIZE)
    @printer = Printer.new
  end

  def seed_board
    @board.seed_life
  end

  def pass_time
    print_board(@board, @iteration)

    until @iteration == MAX_ITERATIONS
      sleep(1)

      @board.next_life!
      @iteration += 1

      print_board(@board, @iteration)
    end
  end

  def print_board(board, iteration)
    @printer.print_board(board, iteration)
  end
end

class Board
  attr_reader :board_size, :grid

  def initialize(board_size, grid=nil)
    @board_size = board_size
    @grid = grid || create_grid
  end

  def seed_life
    @grid.each do |row|
      row.each do |cell|
        coin_toss = [true, false, false, false, false].sample
        cell.ressurect if coin_toss
      end
    end
  end

  def next_life!
    new_grid = []

    @grid.each do |row|
      new_array = []
      row.each do |cell|
        new_array << Cell.new(cell.x_loc, cell.y_loc, should_be_alive?(cell))
      end
      new_grid << new_array
    end

    @grid = new_grid
  end

  def live_neighbors_count(cell)
    neighbors = neighbors(cell)
    neighbors.count { |cell| cell.alive? }
  end

  # please test this monster
  def neighbors(cell)
    neighbors = []

    x_loc = cell.x_loc
    y_loc = cell.y_loc

    # #north
    # neighbors << @grid.dig(x_loc - 1, y_loc) if x_loc > 0
    # #east
    # neighbors << @grid.dig(x_loc, y_loc + 1)
    # #south
    # neighbors << @grid.dig(x_loc + 1, y_loc)
    # #west
    # neighbors << @grid.dig(x_loc, y_loc - 1) if y_loc > 0
    # #northwest
    # neighbors << @grid.dig(x_loc - 1, y_loc - 1) if y_loc > 0 && x_loc > 0
    # #northeast
    # neighbors << @grid.dig(x_loc - 1, y_loc + 1) if x_loc > 0
    # #southwest
    # neighbors << @grid.dig(x_loc + 1, y_loc - 1) if y_loc > 0
    # #southeast
    # neighbors << @grid.dig(x_loc + 1, y_loc + 1)
    #
    #north
    neighbors << @grid.dig(y_loc - 1, x_loc) if y_loc > 0
    #east
    neighbors << @grid.dig(y_loc, x_loc + 1)
    #south
    neighbors << @grid.dig(y_loc + 1, x_loc)
    #west
    neighbors << @grid.dig(y_loc, x_loc - 1) if x_loc > 0
    #northwest
    neighbors << @grid.dig(y_loc - 1, x_loc - 1) if x_loc > 0 && y_loc > 0
    #northeast
    neighbors << @grid.dig(y_loc - 1, x_loc + 1) if y_loc > 0
    #southwest
    neighbors << @grid.dig(y_loc + 1, x_loc - 1) if x_loc > 0
    #southeast
    neighbors << @grid.dig(y_loc + 1, x_loc + 1)

    neighbors.compact
  end

  def should_be_alive?(cell)
    live_count = live_neighbors_count(cell)

    if cell.alive?
      # rule 1
      return false if live_count < 2
      # rule 2
      return true if [2,3].include?(live_count)
      # rule 3
      return false if live_count > 3
    elsif cell.dead?
      # rule 4
      return true if live_count == 3
    end
    false
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
  attr_reader :x_loc, :y_loc

  def initialize(x_loc, y_loc, alive=false)
    @x_loc = x_loc
    @y_loc = y_loc
    @alive = alive
  end

  def ressurect
    @alive = true
  end

  def kill
    @alife = false
  end

  def alive?
    !!@alive
  end

  def dead?
    !@alive
  end
end

# overkill? you betcha
# coupled? you betcha
class Printer
  def print_board(board, iteration)
    system "clear"
    puts "Iteration #{iteration}"
    board.grid.map do |row|
      row.each do |cell|
        print cell.alive? ? "O" : " "
        print " "
      end
      puts
    end
    puts
  end
end
