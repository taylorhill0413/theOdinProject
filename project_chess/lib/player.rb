class Player
  attr_reader :name, :symbol

  def initialize
    @name = name
    @symbol = symbol
  end

  def input
    print 'Input name A:'
    name1 = gets.chomp
    print 'Input name B:'
    name2 = gets.chomp
  end
end
