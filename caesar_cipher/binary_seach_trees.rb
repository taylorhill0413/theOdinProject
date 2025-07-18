class Node
  attr_accessor :data, :left, :right

  def initialize(data)
    self.data = data
    self.left = nil
    self.right = nil
  end

  def <=>(other)
    data <=> other.data
  end
end

class Tree
  attr_accessor :root, :array

  @root

  def initialize(array)
    self.array = array
    @root = build_tree
  end

  def remove_duplicate(array)
    result = []
    array.each do |item|
      result << item if result.include?(item) == false
    end
    result
  end

  def sort(array)
    return array if array.length <= 1

    mid = array.length / 2
    sorted = []

    left = sort(array.slice(0, mid))
    right = sort(array.slice(mid, array.length - mid))

    until left.empty? || right.empty?
      sorted << if left.first > right.first
                  right.shift

                else
                  left.shift

                end
    end

    sorted + left + right
  end

  def build_branch(array, start_, end_)
    return nil if start_ > end_

    mid = (start_ + end_) / 2
    root = Node.new(array[mid])
    root.left = build_branch(array, start_, mid - 1)
    root.right = build_branch(array, mid + 1, end_)
    root
  end

  def build_tree
    self.array = remove_duplicate(array)
    self.array = sort(array)
    build_branch(array, 0, array.length - 1)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(value)
    if @root.nil?
      @root = Node.new(value)
      return @root
    end

    recursive_insert(value, @root)
  end

  def recursive_insert(value, current)
    if value < current.data
      if current.left.nil?
        current.left = Node.new(value)
        return
      else
        recursive_insert(value, current.left)
      end

    end
    return unless value > current.data

    if current.right.nil?
      current.right = Node.new(value)
      nil
    else
      recursive_insert(value, current.right)
    end
  end

  def delete(value)
    return nil if @root.nil?

    recursive_delete(value, @root)
    @root
  end

  def recursive_delete(value, current)
    return nil if current.nil?

    if value < current.data
      current.left = recursive_delete(value, current.left)
    elsif value > current.data
      current.right = recursive_delete(value, current.right)
    else
      current = handle_delete(current)
    end

    current
  end

  def handle_delete(node)
    if node.left.nil? && node.right.nil?
      return nil
    elsif node.left.nil?
      return node.right
    elsif node.right.nil?
      return node.left
    end

    successor = find_min(node.right)
    node.data = successor.data
    node.right = recursive_delete(successor.data, node.right)
    node
  end

  def find_min(node)
    node = node.left while node.left
    node
  end

  def find(value, node = @root)
    return node if node.nil?

    if value < node.data
      find(value, node.left)
    elsif value > node.data
      find(value, node.right)
    else
      puts "Found node: #{node.data}"
      node
    end
  end

  def level_order
    return [] if @root.nil?

    queue = [@root]
    result = []

    until queue.empty?
      node = queue.shift
      result << node.data
      queue << node.left if node.left
      queue << node.right if node.right
    end
    result
  end

  def inorder(node = @root, result = [], &block) # <left><root><right>
    return result if node.nil?

    inorder(node.left, result, &block)
    if block_given?
      yield(node.data)
    else
      result << node.data
    end

    inorder(node.right, result, &block)

    result
  end

  def preorder(node = @root, result = [], &block) # <root><left><right>
    return result if node.nil?

    if block_given?
      yield(node.data)
    else
      result << node.data
    end

    preorder(node.left, result, &block)
    preorder(node.right, result, &block)

    result
  end

  def postorder(node = @root, result = [], &block) # <left><right><root>
    return result if node.nil?

    postorder(node.left, result, &block)
    postorder(node.right, result, &block)
    if block_given?
      yield(node.data)
    else
      result << node.data
    end

    result
  end

  def height(value)
    # returns the height of the node containing that value
    # height is number of edges from that node down to the deepest leaf

    node = find(value)
    return nil if node.nil?

    height_recursion(node)
  end

  def height_recursion(node)
    return -1 if node.nil?

    left_height = height_recursion(node.left)
    right_height = height_recursion(node.right)

    [left_height, right_height].max + 1
  end

  def depth(value)
    # returns the depth of the node containing that value
    # depth is the number of edges in the path from node to the tree root node
    return nil if @root.nil?

    depth_recursion(@root, value)
  end

  def depth_recursion(node, value, count = 0)
    if value < node.data
      node.left = depth_recursion(node.left, value, count += 1)
    elsif value > node.data
      node.right = depth_recursion(node.right, value, count += 1)
    elsif node.data == value
      count
    end
  end

  def balanced?(node = @root)
    # checks if the tree is balanced
    # balanced is when both subtree's height is balanced

    return true if node.nil? # an empty tree is always balanced

    left_height = height_recursion(node.left)
    right_height = height_recursion(node.right)

    # balance factor of every node is between -1 and 1
    return false if (left_height - right_height).abs > 1

    balanced?(node.left) && balanced?(node.right)
  end

  def rebalance
    # balance an unbalanced tree
    @root = build_tree(rebalance_recursion(@root))
    pretty_print
  end

  def rebalance_recursion(node, result = [])
    return result if node.nil?

    rebalance_recursion(node.left, result)
    result << node.data
    rebalance_recursion(node.right, result)

    result
  end
end

list = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]) # [1, 3, 4, 5, 7, 8, 9, 23, 67, 324, 6345]

list.insert(10)
# list.delete(7)
list.pretty_print
# list.find(4)
# print list.level_order
# print list.inorder
# print list.height(67)
print list.depth(10)
