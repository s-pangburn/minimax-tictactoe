require './player'
require './board'

class Game
  def initialize
    @player_1 = Player.new('X')
    @player_2 = Player.new('O')
    @board = Board.new
  end

  # Main game loop
  def start
    winner = "draw"
    puts "\n Tic Tac Toe"
    @board.draw

    while true
      move = make_move('X')
      if check_win(move)
        winner = @board.get_coordinate(move[0], move[1])
        break
      end
      break if @board.full?

      move = make_move('O')
      if check_win(move)
        winner = @board.get_coordinate(move[0], move[1])
        break
      end
      break if @board.full?
    end

    if winner != "draw"
      puts "#{winner} wins!"
    else
      puts "The board is full. Game over!"
    end
  end

  private

  def make_move(player)
    move = []
    print "#{player}'s turn. Please enter the coordinates ",
          "of your move (x, y): "
    loop do
      move = get_input
      if @board.update(player, move[0], move[1])
        break
      else
        print "That space is already taken. Try again: "
      end
    end
    @board.draw
    move
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

  def check_win(move)
    if @board.check_win(move[0], move[1])
      true
    else
      false
    end
  end
end

game = Game.new
game.start
