# Draws the board and tracks game progress
class Board
  def initialize
    @board = Array.new(3){Array.new(3)}
    0.upto(2) do |i|
      0.upto(2) do |j|
        @board[i][j] = "."
      end
    end
  end

  # Draw the board in console
  def draw
    print "\n    1  2  3  \n\n"
    row = 1
    @board.each do |i|
      print " #{row} "
      i.each do |j|
        print " " + j + " "
      end
      print "\n\n"
      row += 1
    end
    print "\n"
  end

  def get_coordinate(x, y)
    @board[x][y]
  end

  def get_legal_moves
    results = []
    0.upto(2) do |i|
      0.upto(2) do |j|
        if @board[i][j] == '.'
          results.push([i, j])
        end
      end
    end
    results
  end

  #Update the game board at coordinates(x, y), return success
  def update(player, x, y)
    if @board[x][y] == "."
      @board[x][y] = player
      true
    else
      false
    end
  end

  # Checks if a particular player has won
  def check_win(char)
    0.upto(2) do |x|
      if @board[x][0] == @board[x][1] && @board[x][1] == @board[x][2]
        return true unless @board[x][0] != char
      end
    end
    0.upto(2) do |y|
      if @board[0][y] == @board[1][y] && @board[1][y] == @board[2][y]
        return true unless @board[0][y] != char
      end
    end
    if @board[0][0] == @board[1][1] && @board[1][1] == @board[2][2]
      return true unless @board[0][0] != char
    end
    if @board[0][2] == @board[1][1] && @board[1][1] == @board[2][0]
      return true unless @board[2][0] != char
    end
    return false
  end

  # Checks if the board is full
  def full?
    @board.each do |i|
      i.each do |j|
        if j == "."
          return false
        end
      end
    end
    true
  end

  # Checks if the game is finished
  def finished?
    full? || check_win('X') || check_win('O')
  end
end
