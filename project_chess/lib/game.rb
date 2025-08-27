require_relative 'board'
require_relative 'player'

class Game
  def initialize
    @board = Board.new
    @player = input_player
  end

  def input_player
    print 'Input name of player A:'
    name1 = gets.chomp
    print 'Input name of player B:'
    name2 = gets.chomp
    [Player.new(name1, 'A'), Player.new(name2, 'B')]
  end

  def play
    @board.display_board
    index_player = 0
    loop do
      current_player = @player[index_player]
      puts "#{current_player.name}'s turn with player #{current_player.symbol}"
      @board.input_move(current_player.symbol)
      win = @board.is_win?(current_player.symbol)
      if win
        puts "Player #{current_player.name} win"
        break
      end
      # swtich player
      index_player = 1 - index_player
    end
  end
end

game = Game.new
game.play
