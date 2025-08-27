class Board
  attr_reader :grid

  PLAYER_A = { 'king' => "\u{2654}", 'queen' => "\u{2655}", 'rook' => "\u{2656}", 'bishop' => "\u{2657}", 'knight' => "\u{2658}",
               'pawn' => "\u2659" }
  PLAYER_B = { 'king' => "\u{265A}", 'queen' => "\u{265B}", 'rook' => "\u{265C}", 'bishop' => "\u{265D}", 'knight' => "\u{265E}",
               'pawn' => "\u{265F}" }
  ROOK_MOVES = { 'rank_left' => [], 'rank_right' => [], 'file_up' => [], 'file_down' => [] }
  BISHOP_MOVES = { 'diagonal_up' => [], 'diagonal_down' => [] }
  KING_MOVES = []
  QUEEN_MOVES = { 'file_up' => [], 'file_down' => [], 'rank_left' => [], 'rank_right' => [], 'diagonal_up' => [],
                  'diagonal_down' => [] }
  KNIGHT_MOVES = []
  PAWN_MOVES = { 'file_up' => [], 'file_down' => [], 'diagonal_up' => [], 'diagonal_down' => [] }
  ROWS = 8
  def initialize
    @grid = Array.new(ROWS) { Array.new(ROWS, nil) }
    start_board
    create_move('A')
    create_move('B')
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

  def create_move(player)
    [[0, 1], [0, -1], [1, 1], [-1, -1], [-1, 1], [1, -1], [1, 0], [-1, 0]].each do |c|
      KING_MOVES << c
    end

    (1..7).each do |count|
      ROOK_MOVES['rank_right'] << [0, count]
      ROOK_MOVES['rank_left'] << [0, -count]
      ROOK_MOVES['file_down'] << [count, 0]
      ROOK_MOVES['file_up'] << [-count, 0]
      QUEEN_MOVES['file_down'] << [count, 0]
      QUEEN_MOVES['file_up'] << [-count, 0]
      QUEEN_MOVES['rank_right'] << [0, count]
      QUEEN_MOVES['rank_left'] << [0, -count]
      BISHOP_MOVES['diagonal_up'] << [count, count]
      QUEEN_MOVES['diagonal_up'] << [count, count]
      BISHOP_MOVES['diagonal_up'] << [-count, -count]
      QUEEN_MOVES['diagonal_up'] << [-count, -count]
      BISHOP_MOVES['diagonal_down'] << [-count, count]
      QUEEN_MOVES['diagonal_down'] << [-count, count]
      BISHOP_MOVES['diagonal_down'] << [count, -count]
      QUEEN_MOVES['diagonal_down'] << [count, -count]
    end

    [[2, 1], [1, 2], [2, -1], [1, -2], [-2, 1], [-1, 2], [-2, -1], [-1, -2]].each do |c|
      KNIGHT_MOVES << c
    end

    if player == 'A'
      PAWN_MOVES['file_down'] = [[1, 0], [2, 0]]
      PAWN_MOVES['diagonal_down'] = [[1, -1], [1, 1]]
    elsif player == 'B'
      PAWN_MOVES['file_up'] = [[-1, 0], [-2, 0]]
      PAWN_MOVES['diagonal_up'] = [[-1, -1], [-1, 1]]
    end

    # print PAWN_MOVES
  end

  def valid_move?(move)
    move[0] >= 0 && move[0] < ROWS && move[1] >= 0 && move[1] < ROWS
  end

  def input_move(player)
    loop do
      print "Input position chess for player #{player}:"
      move = gets.chomp
      move = move.gsub(' ', '')
      move = move.split(',')
      raise_error 'No chess found' if grid[move[0].to_i][move[1].to_i].nil?
      new_pos = which_move(move, player)
      print 'New postion can move: '
      new_pos.map { |pos| print "#{pos} " }
      puts ''
      next if new_pos.empty?

      print 'Which postion you move? '
      move_player = gets.chomp
      move_player = move_player.gsub(' ', '')
      move_player = move_player.split(',')
      raise_error 'Wrong postion' unless valid_move?([move_player[0].to_i,
                                                      move_player[1].to_i]) && !new_pos.find do |pos|
                                                                                 pos[0] == move_player[0].to_i && pos[1] == move_player[1].to_i
                                                                               end.nil?
      update_move(move_player, move)
      display_board
      break
    end
  end

  def is_win?(player)
    if player == 'A'
      player_select = PLAYER_B
    elsif player == 'B'
      player_select = PLAYER_A
    end
    grid.each do |value|
      value.each do |v|
        return false if v == player_select['king']
      end
    end

    true
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
    when 'knight'
      KNIGHT_MOVES.each do |move_|
        new_x = move[0].to_i + move_[0].to_i
        new_y = move[1].to_i + move_[1].to_i
        new_pos << [new_x, new_y] if valid_move?([new_x, new_y])
      end
    when 'queen'
      QUEEN_MOVES.each do |key, value|
        value.each do |move_|
          new_x = move[0].to_i + move_[0].to_i
          new_y = move[1].to_i + move_[1].to_i
          next unless valid_move?([new_x, new_y])
          break unless player_select.key(grid[new_x][new_y]).nil?

          new_pos << [new_x, new_y]
        end
      end
    when 'rook'
      ROOK_MOVES.each do |key, value|
        value.each do |move_|
          new_x = move[0].to_i + move_[0].to_i
          new_y = move[1].to_i + move_[1].to_i

          next unless valid_move?([new_x, new_y])
          break unless player_select.key(grid[new_x][new_y]).nil?

          unless player_nonselect.key(grid[new_x][new_y]).nil?
            new_pos << [new_x, new_y]
            break
          end
          new_pos << [new_x, new_y]
        end
      end
    when 'bishop'
      BISHOP_MOVES.each do |key, value|
        value.each do |move_|
          new_x = move[0].to_i + move_[0].to_i
          new_y = move[1].to_i + move_[1].to_i
          next unless valid_move?([new_x, new_y])
          break unless player_select.key(grid[new_x][new_y]).nil?

          unless player_nonselect.key(grid[new_x][new_y]).nil?
            new_pos << [new_x, new_y]
            break
          end
          new_pos << [new_x, new_y]
        end
      end
    when 'pawn'
      if player == 'A'
        pawn_file = PAWN_MOVES['file_down']
        pawn_diagonal = PAWN_MOVES['diagonal_down']
      elsif player == 'B'
        pawn_file = PAWN_MOVES['file_up']
        pawn_diagonal = PAWN_MOVES['diagonal_up']
      end
      pawn_file.each do |move_|
        new_x = move[0].to_i + move_[0].to_i
        new_y = move[1].to_i + move_[1].to_i
        new_pos << [new_x, new_y] if valid_move?([new_x, new_y])
      end

      pawn_diagonal.each do |move_|
        new_x = move[0].to_i + move_[0].to_i
        new_y = move[1].to_i + move_[1].to_i
        new_pos << [new_x, new_y] if valid_move?([new_x, new_y]) && !player_nonselect.key(grid[new_x][new_y]).nil?
      end
    else
      raise_error 'Not found chess'
    end
    result = []
    new_pos.each do |pos|
      chess_value = grid[pos[0]][pos[1]]
      if chess_value.nil?
        result << pos
      elsif !player_nonselect.key(chess_value).nil?
        result << pos
      end
    end
    result.uniq
  end

  def display_board
    i = 0
    print '  |  '
    (0..7).each do |index|
      print "#{index} |  "
    end
    puts ''
    grid.map do |row|
      print "#{i} | "
      row.map do |cell|
        if cell.nil?
          print '   | '
        else
          print " #{cell} | "
        end
      end
      i += 1

      puts ''
    end
  end
end

# board = Board.new
# # board.display_board
# print board.is_win?('A')
# board.input_move('A')
# board.display_board
