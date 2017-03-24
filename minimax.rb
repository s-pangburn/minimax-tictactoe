# Represents each player, tracks score
class MinimaxAI
  def initialize(char)
    @char = char
    @opponent = @char == 'O' ? 'X' : 'O'
    @choice = 0
  end

  # Evaluates board based on minimax, then returns the optimal move
  def make_move(board)
    puts "Opponent is thinking...\n"
    minimax(board, @char)
    if @board.update('O', @choice[0], @choice[1])
      @board.draw
      puts "Opponent chose coordinates (#{move[0]+1}, #{move[1]+1})\n"
    else
      puts "Something went wrong. The opponent made an illegal move.\n"
    end
  end

  private

  # Minimax implementation
  def minimax(board, turn)
    return score(board) if board.finished?
    scores = []
    moves = []

    # Score every possible move and allocate into tracking variables
    board.get_legal_moves.each do |move|
      if turn == @char
        possible_move = Marshal::load(Marshal.dump(board))
        possible_move.update(@char, move[0], move[1])
        scores.push minimax(possible_move, @opponent)
      else
        possible_move = Marshal::load(Marshal.dump(board))
        possible_move.update(@opponent, move[0], move[1])
        scores.push minimax(possible_move, @char)
      end
      moves.push move
    end

    # Set choice to the best move found and return (for recursion)
    if turn == @char
      best_score_index = scores.each_with_index.max[1]
      @choice = moves[best_score_index]
      return scores[best_score_index]
    else
      worst_score_index = scores.each_with_index.min[1]
      @choice = moves[worst_score_index]
      return scores[worst_score_index]
    end
  end

  # Board evaluation heuristic
  def score(board)
    if board.check_win(@char)
      return 10
    elsif board.check_win(@opponent)
      return -10
    else
      return 0
    end
  end
end
