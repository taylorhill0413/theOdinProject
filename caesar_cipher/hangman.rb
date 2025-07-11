require 'yaml'
class Hangman
  DICTIONARY = File.readlines('./google-10000-english-no-swears.txt', chomp: true)
  attr_accessor :secret_word, :guess_word, :game, :wrong_answer

  def initialize
    self.secret_word = DICTIONARY.select { |word| word.length >= 5 && word.length <= 12 }.sample.upcase
    self.guess_word = []
    secret_word.length.times do
      guess_word.push('_')
    end
  end

  def display
    Gem.win_platform? ? (system 'cls') : (system 'clear')
    guess_word.each_with_index do |item, _index|
      print "\s#{item}\s"
    end
    puts ''
  end

  def load_game
    return unless File.exist?('game.yaml')

    self.game = YAML.load_file('game.yaml') || {}
  end

  def save(data)
    File.open('game.yaml', 'w') { |f| f.write(data.to_yaml) }
  end

  def play_game
    load_game
    print 'Do you want to load saved game?(Y/N) '
    load_ = gets.chomp
    if load_.upcase == 'Y'
      puts ''
      print "What's name of game you save? "
      name = gets.chomp
      puts ''
      self.secret_word = game[name]['secret_word']
      self.guess_word = game[name]['guess_word']
      self.wrong_answer = game[name]['wrong_answer']
      display
    else
      display
      puts "You need to guess word has #{secret_word.length} chars"
      wrong_answer = 8
    end

    loop do
      puts "You have #{wrong_answer} wrong answer left"
      if wrong_answer.zero?
        puts 'You are lose'
        puts "Secret word is: #{secret_word}"
        return
      end
      print 'Your guess:'
      guess = gets.chomp.upcase
      wrong_answer -= 1 if secret_word.include?(guess) == false
      secret_word.length.times do |i|
        guess_word[i] = guess if secret_word[i] == guess
      end
      display
      if guess_word.join == secret_word
        puts 'You are win'
        return
      end
      print 'Do you want to save this game?(Y/N) '
      load_ = gets.chomp
      next unless load_.upcase == 'Y'

      puts ''
      print "What's name of game you save? "
      name_ = gets.chomp
      game[name_] =
        { 'name' => name_, 'secret_word' => secret_word, 'guess_word' => guess_word, 'wrong_answer' => wrong_answer }
      save(game)
    end
  end
end

one = Hangman.new
one.play_game
