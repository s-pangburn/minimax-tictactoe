require './minimax'
require './board'

class Game
  def initialize
    @board = Board.new
    @enemy = MinimaxAI.new('O')
  end

  # Main game loop
  def start
    winner = "draw"
    puts "\n Tic Tac Toe"
    @board.draw

    while true
      make_move('X')
      if check_win('X')
        winner = 'X'
        break
      end
      break if @board.full?

      @enemy.make_move(@board)
      if check_win('O')
        winner = 'O'
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
        @board.draw
        puts "Updated board at coordinates (#{move[0]+1}, #{move[1]+1})"
        break
      else
        print "That space is already taken. Try again: "
      end
    end
    move
  end

  def get_input()
    result = []
    loop do
      input = gets.chomp
      exit if input == "quit" || input == "q"
      move = input.match(/^\(?(\d+),?\s*(\d+)\)?/)

      if !move.nil? && !move[1].empty? && !move[2].empty?
        result[0] = move[1].to_i - 1
        result[1] = move[2].to_i - 1
        if result[0].between?(0,2) && result[1].between?(0,2)
          break
        else
          print "Please enter coordinates between (1, 1) and (3, 3): "
        end
      else
        print "Invalid input, please try again: "
      end
    end
    result
  end

  def check_win(player)
    if @board.check_win(player)
      true
    else
      false
    end
  end
end
