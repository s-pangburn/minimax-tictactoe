require './player'
require './board'

class Game
  def initialize
    @player_1 = Player.new('X')
    @player_2 = Player.new('O')
    @board = Board.new
  end

  def start
    puts "Tic Tac Toe - version 0.0.1"

    # Game Loop
    while true
      @board.draw

      print "X's turn. Please enter the coordinates ",
            "of your move (x, y): "
      make_move('X')

      @board.draw

      print "O's turn. Please enter the coordinates ",
            "of your move (x, y): "
      make_move('O')

      # break
    end
  end

  private

  def make_move(player)
    loop do
      move = get_input
      if @board.update(player, move[0], move[1])
        break
      else
        print "That space is already taken. Try again: "
      end
    end
  end

  def get_input()
    result = []
    loop do
      input = gets.chomp
      exit if input == "quit" || input == "q"
      move = input.match(/^\(?(\d+),?\s*(\d+)\)?/)

      if !move.nil? && !move[1].empty? && !move[2].empty?
        result[0] = move[1].to_i
        result[1] = move[2].to_i
        if result[0].between?(0,2) && result[1].between?(0,2)
          break
        else
          print "Please enter coordinates between (0, 0) and (2, 2): "
        end
      else
        print "Invalid input, please try again: "
      end
    end
    result
  end
end

game = Game.new
game.start
