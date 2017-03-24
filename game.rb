require './minimax'
require './board'

class Game
  def initialize
    @enemy = MinimaxAI.new('O')
    @board = Board.new
  end

  # Main game loop
  def start
    winner = "draw"
    puts "\n Tic Tac Toe"
    @board.draw

    while true
      move = make_move('X')
      if check_win('X')
        winner = @board.get_coordinate(move[0], move[1])
        break
      end
      break if @board.full?

      puts "Opponent is thinking...\n"
      move = @enemy.make_move(@board)
      if @board.update('O', move[0], move[1])
        @board.draw
        puts "Opponent chose coordinates (#{move[0]+1}, #{move[1]+1})\n"
      else
        puts "Something went wrong. The opponent made an illegal move.\n"
      end
      if check_win('O')
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
