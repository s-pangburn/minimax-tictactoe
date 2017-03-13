# Draws the board and tracks game progress
class Board
  def initialize
    @game_board = Array.new(3){Array.new(3)}
    0.upto(2) do |i|
      0.upto(2) do |j|
        @game_board[i][j] = "."
      end
    end
  end

  # Draw the board in console
  def draw
    print "\n"
    @game_board.each do |i|
      i.each do |j|
        print " " + j + " "
      end
      print "\n\n"
    end
    print "\n"
  end

  #Update the game board at coordinates(x, y) with character player
  def update(player, x, y)
    @game_board[x][y] = player
    puts "Updated board at coordinates (#{x}, #{y})"
  end
end
