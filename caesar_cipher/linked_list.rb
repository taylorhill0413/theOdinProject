class Node
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
    self.value = value
    self.next_node = next_node
  end
end

class LinkedList
  def initialize
    @head = nil
  end

  def append(value)
    new_node = Node.new(value)
    if @head.nil?
      @head = new_node
    else
      current = @head
      current = current.next_node while current.next_node
      current.next_node = new_node
    end
  end

  def prepend(value)
    new_node = Node.new(value)
    new_node.next_node = @head
    @head = new_node
  end

  def size
    current = @head
    count = 0
    while current
      count += 1
      current = current.next_node
    end
    count
  end

  attr_reader :head

  def tail
    current = @head
    current = current.next_node until current.next_node.nil?
    current
  end

  def at(index)
    current = @head
    count = 0
    while current
      return current if index == count

      count += 1
      current = current.next_node
    end
    puts "Index wasn't found"
  end

  def pop
    return if @head.nil?

    if @head.next_node.nil?
      @head = nil
      return
    end
    current = @head
    current = current.next_node until current.next_node.next_node.nil?
    deleted_node = current.next_node
    current.next_node = nil
    deleted_node
  end

  def contains?(value)
    current = @head
    until current.next_node.nil?
      return true if current.value == value

      current = current.next_node
    end
    false
  end

  def find(value)
    current = @head
    index = 0
    until current.next_node.nil?
      return index if current.value == value

      index += 1
      current = current.next_node
    end
    nil
  end

  def to_s
    current = @head
    while current
      print "(#{current.value}) -> "
      current = current.next_node
    end
    puts 'nil'
  end

  def insert_at(value, index)
    return prepend(value) if index == 0

    current = @head
    count = 0
    while current && count < (index - 1)
      count += 1
      current = current.next_node
    end
    puts 'Index out of limit' if current.nil?
    new_node = Node.new(value)
    new_node.next_node = current.next_node
    current.next_node = new_node
  end

  def remove_at(index)
    return 'Index out of limit' if @head.nil?

    @head = @head.next_node if index == 0
    current = @head
    count = 0
    while current && (index - 1)
      count += 1
      current = current.next_node
    end

    puts 'Index out of limit' if current.nil? || current.next_node.nil?
    current.next_node = current.next_node.next_node
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
