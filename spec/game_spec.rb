require "spec_helper"
require_relative "../lib/game"


describe Board do
  let(:board) { Board.new(3, grid) }

  # visual representation of a board
  # false false false
  # false true false
  # false false false

  describe "#neighbors" do
    let(:grid) do
      [[top_left, top, top_right],
       [left, middle, right],
       [bottom_left, bottom, bottom_right]]
    end

    let(:top_left) { Cell.new(0, 0) }
    let(:top) { Cell.new(0, 1) }
    let(:top_right) { Cell.new(0, 2) }
    let(:left) { Cell.new(1, 0) }
    let(:middle) { Cell.new(1, 1) }
    let(:right) { Cell.new(1, 2) }
    let(:bottom_left) { Cell.new(2, 0) }
    let(:bottom) { Cell.new(2, 1) }
    let(:bottom_right) { Cell.new(2, 2) }

    context "when the cell is in the middle of the board" do
      it "should return 8 specific neighbors" do
        expect(board.neighbors(middle).count).to eq 8
        expect(board.neighbors(middle)).to include top_left, top, top_right, left, right, bottom_left, bottom, bottom_right
      end
    end

    context "when the cell is on the top left corner" do
      it "should return 3 specific neighbors" do
        expect(board.neighbors(top_left).count).to eq 3
        expect(board.neighbors(top_left)).to include top, middle, left
      end
    end

    context "when the cell is on the bottom right corner" do
      it "should return 3 specific neighbors" do
        expect(board.neighbors(bottom_right).count).to eq 3
        expect(board.neighbors(bottom_right)).to include bottom, middle, right
      end
    end

    context "when the cell is on the top middle edge" do
      it "should return 5 specific neighbors" do
        expect(board.neighbors(top).count).to eq 5
        expect(board.neighbors(top)).to include top_left, left, middle, right, top_right
      end
    end
  end

  describe "#should_be_alive?" do
    let(:grid) do
      [[top_left, top, top_right],
       [left, middle, right],
       [bottom_left, bottom, bottom_right]]
    end

    let(:top_left) { Cell.new(0, 0) }
    let(:top) { Cell.new(0, 1) }
    let(:top_right) { Cell.new(0, 2) }
    let(:left) { Cell.new(1, 0) }
    let(:middle) { Cell.new(1, 1, true) }
    let(:right) { Cell.new(1, 2) }
    let(:bottom_left) { Cell.new(2, 0) }
    let(:bottom) { Cell.new(2, 1) }
    let(:bottom_right) { Cell.new(2, 2) }

    context "when the cell is alive and has less than 2 live neighbors" do
      let(:left) { Cell.new(1,0, true) }

      it "should die" do
        expect(board.should_be_alive?(middle)). to be false
      end
    end

    context "when the cell is alive and has less than 2 live neighbors" do
      let(:left) { Cell.new(1, 0, true) }
      let(:right) { Cell.new(1, 2, true) }

      it "should live" do
        expect(board.should_be_alive?(middle)). to be true
      end
    end

    context "when the cell is alive and has less than 3 live neighbors" do
      let(:left) { Cell.new(1, 0, true) }
      let(:right) { Cell.new(1, 2, true) }
      let(:bottom) { Cell.new(2, 1, true) }

      it "should live" do
        expect(board.should_be_alive?(middle)). to be true
      end
    end

    context "when the cell is alive and has more than 3 neighbors" do
      let(:left) { Cell.new(1, 0, true) }
      let(:right) { Cell.new(1, 2, true) }
      let(:bottom) { Cell.new(2, 1, true) }
      let(:bottom_right) { Cell.new(2, 2, true) }

      it "should live" do
        expect(board.should_be_alive?(middle)). to be false
      end
    end

    context "when the cell is dead and has exactly 3 neighbors" do
      let(:middle) { Cell.new(1,1, false) }
      let(:left) { Cell.new(1, 0, true) }
      let(:right) { Cell.new(1, 2, true) }
      let(:bottom) { Cell.new(2, 1, true) }

      it "should live" do
        expect(board.should_be_alive?(middle)). to be true
      end
    end

    context "when the cell is dead and has more than 3 neighbors" do
      let(:middle) { Cell.new(1,1, false) }
      let(:left) { Cell.new(1, 0, true) }
      let(:right) { Cell.new(1, 2, true) }
      let(:bottom) { Cell.new(2, 1, true) }
      let(:bottom_right) { Cell.new(2, 2, true) }

      it "should live" do
        expect(board.should_be_alive?(middle)). to be false
      end
    end
  end
end
