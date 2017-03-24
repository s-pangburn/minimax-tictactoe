# Represents each player, tracks score
class MinimaxAI
  def initialize(char)
    @char = char
    @opponent = @char == 'O' ? 'X' : 'O'
    @choice = 0
  end

  def make_move(board)
    minimax(board, @char)
    @choice
  end

  # Rough sketch, not tested, incomplete
  def minimax(board, turn)
    return score(board) if board.finished?
    scores = []
    moves = []

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
