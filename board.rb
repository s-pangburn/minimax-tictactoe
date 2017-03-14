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

  #Update the game board at coordinates(x, y), return success
  def update(player, x, y)
    if @board[x][y] == "."
      @board[x][y] = player
      puts "Updated board at coordinates (#{x+1}, #{y+1})"
      true
    else
      false
    end
  end

  def check_win(x, y)
    if @board[x][0] == @board[x][1] && @board[x][1] == @board[x][2]
      true
    elsif @board[0][y] == @board[1][y] && @board[1][y] == @board[2][y]
      true
    elsif x == y && @board[0][0] == @board[1][1] && @board[1][1] == @board[2][2]
      true
    elsif x + y == 2 && @board[0][2] == @board[1][1] && @board[1][1] == @board[2][0]
      true
    else
      false
    end
  end

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
end
