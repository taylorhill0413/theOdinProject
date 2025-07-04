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
        print "\u2610 "
      end
      puts ''
      arr.push(column)
    end
  end

  def display_board(arr)
    arr.each do |_i|
      _i.each do |_j|
        print "#{_j} "
      end
      puts ''
    end
  end

  def clear_output
    Gem.win_platform? ? (system 'cls') : (system 'clear')
  end

  def play_game
    puts 'Input match coordinate format: row,column'
    loop do
      print 'User A:'
      data = gets.chomp
      print data
      input_user('A', data.split(',')[0].to_i, data.split(',')[1].to_i)
      print 'User B:'
      data = gets.chomp
      input_user('B', data.split(',')[0].to_i, data.split(',')[1].to_i)
      result = check_condition(arr)
      break unless result.nil?
    end
  end

  def input_user(user, row, column)
    _sym = if user == 'A'
             'X'
           else
             'O'
           end
    if row.to_i.positive? == false || column.to_i.positive? == false || row > rows || column > columns
      print 'Error input rows or columns'
      return
    end
    arr[row - 1][column - 1] = _sym
    clear_output
    display_board(arr)
  end

  def result(arr, target)
    arr.any? do |row|
      row.each_cons(target.length).any? { |subarray| subarray == target }
    end
  end

  def check_condition(arr)
    if result(arr, '%w[X X X]')
      return 'A win'
    elsif result(arr, '%w[O O O]')
      return 'B win'
    end

    arr_column = Array.new(rows)
    arr.each_with_index do |item, index|
      arr_temp = []
      item.each_with_index do |_item, _index|
        arr_temp.push(arr[_index][index])
      end
      arr_column[index] = arr_temp
    end

    if result(arr_column, '%w[X X X]')
      return 'A win'
    elsif result(arr_column, '%w[O O O]')
      return 'B win'
    end

    nil
    # arr_diagonal = Array.new(rows)
    # arr.each_with_index do |item, index|
    #   arr_temp = []
    #   item.each_with_index do |_item, _index|
    #     arr_temp.push(arr[_index + index][_index])
    #   end
    #   arr_diagonal[index] = arr_temp
    # end
  end
end

round1 = TikTacTie.new
round1.play_game
