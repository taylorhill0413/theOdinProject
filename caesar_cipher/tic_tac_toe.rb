# frozen_string_literal: true

class TikTacTie
  attr_accessor :user, :arr, :columns, :rows

  def initialize(rows = 3, columns = 3)
    self.rows = rows
    self.columns = columns
    self.arr = []
    rows.times do |_row|
      column = []
      columns.times do |_column|
        column.push('☐')
        print "  \u2610  |"
      end
      puts ''
      puts '--*--|' * 3
      arr.push(column)
    end
  end

  def display_board(arr)
    arr.each do |_i|
      _i.each do |_j|
        print "  #{_j}  |"
      end
      puts ''
      puts '--*--|' * 3
    end
  end

  def clear_output
    Gem.win_platform? ? (system 'cls') : (system 'clear')
  end

  def play_game
    puts 'Input match coordinate format: row,column'
    loop do
      input_user('A')
      result = check_condition(arr)
      unless result.nil?
        puts result
        break
      end
      input_user('B')

      result = check_condition(arr)
      # puts "#{result} - #{arr}"
      unless result.nil?
        puts result
        break
      end
    end
  end

  def input_user(user)
    5.times do
      print "User #{user}:"
      data = gets.chomp
      row = data.split(',')[0].to_i
      column = data.split(',')[1].to_i
      if arr[row - 1][column - 1].include?('☐') == false
        puts 'Error input: This position is already taken'
        next
      end
      _sym = if user == 'A'
               'X'
             else
               'O'
             end
      if row.to_i.positive? == false || column.to_i.positive? == false || row > rows || column > columns
        puts 'Error input rows or columns'
        next
      end
      arr[row - 1][column - 1] = _sym
      clear_output
      display_board(arr)
      return
    end
    puts 'Error input'
  end

  def result(arr, target)
    for i in 0..arr.length - 2
      for j in 0..arr[i].length - 2
        if arr[i][j] == target && arr[i][j + 1] == target && arr[i][j + 2] == target
          return true
        elsif arr[i][j] == target && arr[i + 1][j] == target && arr[i + 2][j] == target
          return true
        elsif arr[i][j] == target && arr[i + 1][j + 1] == target && arr[i + 2][j + 2] == target
          return true
        end
      end
    end
    false
  end

  def check_condition(arr)
    return 'A win' if result(arr, 'X')
    return 'B win' if result(arr, 'O')

    nil
  end
end

round1 = TikTacTie.new
round1.play_game
