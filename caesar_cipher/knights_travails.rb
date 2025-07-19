class KnightTravail
  KNIGHT_MOVE = [[2, 1], [1, 2], [2, -1], [1, -2], [-2, 1], [-1, 2], [-2, -1], [-1, -2]].freeze
  def initialize(pos = [0, 0])
    @pos = pos
  end

  def valid_move(position)
    x, y = position
    moves = []
    KNIGHT_MOVE.each do |move|
      new_x = x + move[0]
      new_y = y + move[1]
      moves << [new_x, new_y] if new_x.between?(0, 7) && new_y.between?(0, 7)
    end
    moves
  end

  def knight_move(start, target)
    bfs = bfs(start, target)
    print "You made it in #{bfs.size} moves!  Here's your path:"
    puts ''
    bfs.unshift(start)
    bfs.map do |item|
      print item
      puts ''
    end
  end

  def bfs(start, target)
    result = []
    queue = []
    parents = {}
    queue << start

    until queue.empty?
      path = queue.shift
      break if path == target

      result << path
      valid_move(path).each do |move|
        next if result.include?(move)

        queue << move
        result << move
        parents[move] = path
      end
    end
    build_parent(parents, target)
  end

  def build_parent(parents, target)
    path = []
    current = target

    while parents[current]
      path << current
      current = parents[current]
    end
    path.reverse
  end
end

knights = KnightTravail.new
knights.knight_move([3, 3], [0, 0])
