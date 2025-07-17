class LinkedList
  attr_accessor :linked_list

  def initialize(linked_list = [])
    self.linked_list = linked_list
  end

  def append(value)
    linked_list << value
  end

  def prepend(value)
    linked_list.unshift(value)
  end

  def size
    linked_list.length
  end

  def head
    linked_list.first
  end

  def tail
    linked_list.last
  end

  def at(index)
    linked_list[index]
  end

  def pop
    linked_list.pop
  end

  def contains?(value)
    linked_list.include?(value)
  end

  def find(value)
    linked_list.find_index(value)
  end

  def to_s
    linked_list.each do |item|
      print "(#{item}) -> "
    end
    print 'nil'
  end

  def insert_at(value, index)
    linked_list.insert_at(value, index)
  end

  def remove_at(index)
    linked_list.delete_at(index)
  end
end

class Node
  @value = nil
  @next_node = nil
  def initialize
  end
end

list = LinkedList.new

list.append('dog')
list.append('cat')
list.append('parrot')
list.append('hamster')
list.append('snake')
list.append('turtle')

puts list
