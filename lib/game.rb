class Game
  attr_accessor :board, :player_1, :player_2

  WIN_COMBINATIONS =[[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

  def initialize(board = Board.new, player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"))
    @board = board
    @player_1 = player_1
    @player_2 = player_2
  end

  #methods relative to the state of the game
  def current_player(board)
    if turn_count(board) % 2 == 0
      return @player_1
    else
      return @player_2
    end
  end

  def won?(board)
    WIN_COMBINATIONS.detect do |variable|
      win_index_1 = variable[0]
      win_index_2 = variable[1]
      win_index_3 = variable[2]

      position_1 = board[win_index_1]
      position_2 = board[win_index_2]
      position_3 = board[win_index_3]

  if position_1 == position_2 && position_2 == position_3 && position_1 != " "
    return variable # this return just the 3 winning indexes
      end
    end
  end

  def winner
    if winner_board = won?
      @winner = @board.cells[winner_board.first]
    end
  end

  def over?
    draw?|| won?
  end

  def draw?
    !won? && @board.full?
  end


  #methods for managing the game

  def play(board)
    until over?(board)
      turn(board)
    end
      if won?
        puts "Congratulations #{winner}!"
      elsif draw?
        puts "Cats Game!"
      end
    end

  def turn(board)
    player = current_player
    current_move = play.move(board)
    if !@board.valid_move?(current_move) # when writing a conditional statement, in most cases the eval is implicit.
      turn
    else
      puts "Turn: #{@board.turn_count +1}\n"
      @board.display
      @board.update(current_move, player)
      puts "{player.token} moved #{current_move}"
      @board.display
      puts "\n\n"
    end
  end

end