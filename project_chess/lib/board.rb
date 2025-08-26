class Board
  attr_reader :grid

  PLAYER_A = { 'king' => "\u{2654}", 'queen' => "\u{2655}", 'rook' => "\u{2656}", 'bishop' => "\u{2657}", 'knight' => "\u{2658}",
               'pawn' => "\u2659" }
  PLAYER_B = { 'king' => "\u{265A}", 'queen' => "\u{265B}", 'rook' => "\u{265C}", 'bishop' => "\u{265D}", 'knight' => "\u{265E}",
               'pawn' => "\u{265F}" }
  ROOK_MOVES = []
  BISHOP_MOVES = []
  KING_MOVES = []
  QUEEN_MOVES = []
  KNIGHT_MOVES = []
  PAWN_MOVES = []
  ROWS = 8
  def initialize
    @grid = Array.new(ROWS) { Array.new(ROWS, nil) }
    start_board
    create_move
  end

  def start_board
    grid[0] = [PLAYER_A['rook'], PLAYER_A['knight'], PLAYER_A['bishop'], PLAYER_A['queen'], PLAYER_A['king'],
               PLAYER_A['bishop'], PLAYER_A['knight'], PLAYER_A['rook']]
    grid[1] = [PLAYER_A['pawn'], PLAYER_A['pawn'], PLAYER_A['pawn'], PLAYER_A['pawn'], PLAYER_A['pawn'], PLAYER_A['pawn'],
               PLAYER_A['pawn'], PLAYER_A['pawn']]

    grid[6] = [PLAYER_B['pawn'], PLAYER_B['pawn'], PLAYER_B['pawn'], PLAYER_B['pawn'], PLAYER_B['pawn'], PLAYER_B['pawn'],
               PLAYER_B['pawn'], PLAYER_B['pawn']]
    grid[7] = [PLAYER_B['rook'], PLAYER_B['knight'], PLAYER_B['bishop'], PLAYER_B['queen'], PLAYER_B['king'],
               PLAYER_B['bishop'], PLAYER_B['knight'], PLAYER_B['rook']]
  end

  def create_move
    (-7..7).each do |count|
      ROOK_MOVES << [0, count]
      ROOK_MOVES << [count, 0]
      BISHOP_MOVES << [count, count]
      QUEEN_MOVES << [count, 0]
      QUEEN_MOVES << [0, count]
      QUEEN_MOVES << [count, count]
    end

    [[2, 1], [1, 2], [2, -1], [1, -2], [-2, 1], [-1, 2], [-2, -1], [-1, -2]].each do |c|
      KNIGHT_MOVES << c
    end

    [[0, 1], [0, 2], [1, 1], [-1, -1]].each do |c|
      PAWN_MOVES << c
    end
    # print PAWN_MOVES
  end

  def valid_move?(move)
    move[0] >= 0 && move[0] < ROWS && move[1] >= 0 && move[1] < ROWS
  end

  def input_move(player)
    print "Input position chess for player #{player}:"
    move = gets.chomp
    move = move.gsub(' ', '')
    move = move.split(',')
    raise_error 'No chess found' if grid[move[0].to_i][move[1].to_i].nil?
    new_pos = which_move(move, player)
    puts "New postion can move: #{new_pos}"
    print 'Which postion you move? '
    move_player = gets.chomp
    move_player = move_player.gsub(' ', '')
    move_player = move_player.split(',')
    raise_error 'Wrong postion' if valid_move?([move_player[0].to_i, move_player[1].to_i]) == false
    update_move(move_player, move)
    display_board
  end

  def update_move(move_player, move)
    grid[move_player[0].to_i][move_player[1].to_i] = grid[move[0].to_i][move[1].to_i]
    grid[move[0].to_i][move[1].to_i] = nil
  end

  def which_move(move, player)
    if player == 'A'
      player_select = PLAYER_A
      player_nonselect = PLAYER_B
    elsif player == 'B'
      player_select = PLAYER_B
      player_nonselect = PLAYER_A
    end

    chess = player_select.key(grid[move[0].to_i][move[1].to_i])
    new_pos = []
    case chess
    when 'king'
      KING_MOVES.each do |move_|
        new_x = move[0].to_i + move_[0].to_i
        new_y = move[1].to_i + move_[1].to_i
        new_pos << [new_x, new_y] if valid_move?([new_x, new_y])
      end
    when 'queen'
      QUEEN_MOVES.each do |move_|
        new_x = move[0].to_i + move_[0].to_i
        new_y = move[1].to_i + move_[1].to_i
        new_pos << [new_x, new_y] if valid_move?([new_x, new_y])
      end
    when 'rook'
      ROOK_MOVES.each do |move_|
        new_x = move[0].to_i + move_[0].to_i
        new_y = move[1].to_i + move_[1].to_i
        new_pos << [new_x, new_y] if valid_move?([new_x, new_y])
      end
    when 'bishop'
      BISHOP_MOVES.each do |move_|
        new_x = move[0].to_i + move_[0].to_i
        new_y = move[1].to_i + move_[1].to_i
        new_pos << [new_x, new_y] if valid_move?([new_x, new_y])
      end
    when 'knight'
      KNIGHT_MOVES.each do |move_|
        new_x = move[0].to_i + move_[0].to_i
        new_y = move[1].to_i + move_[1].to_i
        new_pos << [new_x, new_y] if valid_move?([new_x, new_y])
      end
    when 'pawn'
      print PAWN_MOVES
      PAWN_MOVES.each do |move_|
        new_x = move[0].to_i + move_[0].to_i
        new_y = move[1].to_i + move_[1].to_i
        new_pos << [new_x, new_y] if valid_move?([new_x, new_y])
      end
    else
      raise_error 'Not found chess'
    end

    new_pos
  end

  def display_board
    grid.map do |row|
      row.map do |cell|
        if cell.nil?
          print '   | '
        else
          print " #{cell} | "
        end
      end
      puts ''
    end
  end
end

board = Board.new
board.display_board
board.input_move('A')
# board.display_board
