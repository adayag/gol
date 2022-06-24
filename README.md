# Game of Life

### Scope
1. Restricted board size.  Post MVP: Can extend to take any size board?
2. Live/Dead cell rules account for edge of board
3. Random population of live cells to start
4. Can do any amount of iterations up to 100? Post MVP: Infinite if cells alive?
5. Can display in terminal.  Post MVP: Can extend to a prettier display or gem?

### Rules
The universe of the Game of Life is an infinite, two-dimensional orthogonal grid of square cells, each of which is in one of two possible states, live or dead (or populated and unpopulated, respectively). Every cell interacts with its eight neighbours, which are the cells that are horizontally, vertically, or diagonally adjacent. At each step in time, the following transitions occur:

Any live cell with fewer than two live neighbours dies, as if by underpopulation.
Any live cell with two or three live neighbours lives on to the next generation.
Any live cell with more than three live neighbours dies, as if by overpopulation.
Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

### Notes as I go
Separation of concerns
* Game
  * responsible for initializing and running the world and iterations/ticks?
* Board
 * responsible for all the information of the grid
 * responsible for determining what will be alive or dead next iteration?
* Cell
  * alive or not alive?
* Printer
  * visually takes an iteration of a board and prints it out

