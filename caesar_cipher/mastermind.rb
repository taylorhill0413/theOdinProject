def colorize(value, color)
  case color
  when 'black' then "\e[30m" + value.to_s + "\e[0m"
  when 'red' then "\e[31m" + value.to_s + "\e[0m"
  when 'green' then "\e[32m" + value.to_s + "\e[0m"
  when 'yellow' then "\e[33m" + value.to_s + "\e[0m"
  when 'blue' then "\e[34m" + value.to_s + "\e[0m"
  when 'magenta' then "\e[35m" + value.to_s + "\e[0m"
  when 'cyan' then "\e[36m" + value.to_s + "\e[0m"
  when 'white' then "\e[37m" + value.to_s + "\e[0m"
  when 'bright_black' then "\e[1m\e[30m" + value.to_s + "\e[0m"
  when 'bright_red' then "\e[1m\e[31m" + value.to_s + "\e[0m"
  when 'bright_green' then "\e[1m\e[32m" + value.to_s + "\e[0m"
  when 'bright_yellow' then "\e[1m\e[33m" + value.to_s + "\e[0m"
  when 'bright_blue' then "\e[1m\e[34m" + value.to_s + "\e[0m"
  when 'bright_magenta' then "\e[1m\e[35m" + value.to_s + "\e[0m"
  when 'bright_cyan' then "\e[1m\e[36m" + value.to_s + "\e[0m"
  when 'bright_white' then "\e[1m\e[37m" + value.to_s + "\e[0m"
  else value.to_s
  end
end

class MasterMind
  COLORS = %w[black red green yellow blue magenta cyan white]
  attr_accessor :count, :secret_code

  def initialize(count = 4)
    self.count = count
    print 'List colors allow: '
    COLORS.map { |color| print colorize("#{color}\s", color) }
  end

  def computer_generate_secret_code(count = 4)
    self.secret_code = []
    count.times do
      secret_code.push(COLORS.sample)
    end
    secret_code
  end

  def play_game
    12.times do
      print "User guest #{count} color(s) array seperated space:"
      guest = gets.chomp
      guest_array = guest.split(' ')
      result = []
      guest_array.each_with_index do |code, index|
        if secret_code[index] == code
          result.push(colorize("|\s", 'red'))
          next
        end
        if secret_code.include?(code)
          result.push(colorize("|\s", 'white'))
          next
        end
      end
      guest_array.map { |code| print "#{colorize(code, code)}\s" }
      print ' => '
      result.map { |r| print r }
      puts ''
      if guest_array == secret_code
        puts 'You are win'
        return
      end
    end
  end
end

new = MasterMind.new
new.computer_generate_secret_code
new.play_game
