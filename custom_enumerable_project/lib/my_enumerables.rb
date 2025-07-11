module Enumerable
  # Your code goes here
  def my_each_with_index(&block)
    return to_enum(:my_each_with_index) unless block_given?

    index = 0
    my_each do |element|
      yield(element, index)
      index += 1
    end
    self
  end

  def my_select(&block)
    return to_enum(:my_select) unless block_given?

    result = []
    my_each do |element|
      result.append(element) if yield(element)
    end
    result
  end

  def my_all?(&block)
    return to_enum(:my_all?) unless block_given?

    my_each do |element|
      return false unless yield(element)
    end
    true
  end

  def my_any?(&block)
    return to_enum(:my_any?) unless block_given?

    my_each do |element|
      return true if yield(element)
    end
    false
  end

  def my_none?(&block)
    return to_enum(:my_none?) unless block_given?

    my_each do |element|
      return false if yield(element)
    end
    true
  end

  def my_count(&block)
    return length unless block_given?

    count = 0
    my_each do |element|
      count += 1 if yield(element)
    end
    count
  end

  def my_map(&block)
    to_enum(:my_map) unless block_given?

    arr = []
    my_each do |element|
      arr << yield(element)
    end
    arr
  end

  def my_inject(initial_value = nil, &block)
    to_enum(:my_inject) unless block_given?
    if initial_value
      result = initial_value
      start_index = 0
    else
      result = first
      start_index = 1
    end

    my_each_with_index do |element, index|
      result = yield(result, element) if index >= start_index
    end
    result
  end
end

# You will first have to define my_each
# on the Array class. Methods defined i
# your enumerable module will have access
# to thi
class Array
  # Define my_each here
  def my_each
    return to_enum(:my_each) unless block_given?

    (0...length).each do |i|
      yield(self[i])
    end
    self
  end
end
