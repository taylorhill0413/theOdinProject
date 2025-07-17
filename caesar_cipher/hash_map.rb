class HashMap
  def initialize(capacity = 16, load_factor = 0.75)
    @capacity = capacity
    @load_factor = load_factor
    @buckets = Array.new(@capacity) { [] }
    @size = 0
  end

  def hash(key)
    hash_code = 0
    prime_number = 31
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    hash_code.abs
  end

  def set(key, value)
    index = hash(key) % @capacity
    bucket = @buckets[index]
    pair = bucket.find { |k, v| k == key }
    if pair
      pair[1] = value
    else
      bucket << [key, value]
      @size += 1
    end

    grow if @size > (@capacity * @load_factor)
  end

  def grow
    @capacity *= 2
    bucket = Array.new(@capacity) { [] }
    @buckets.each do |pair|
      set(pair[0], pair[1])
    end
    @buckets = bucket
  end

  def get(key)
    index = hash(key) % @capacity
    return @buckets[index][1] if @buckets[index][0] == key

    nil
  end

  def has?(key)
    !get(key).nil?
  end

  def remove(key)
    if has?(key)
      index = hash(key) % @capacity
      @buckets[index].each_with_index do |item, index|
        next unless item[0] == key

        @buckets[index].delete_at(index)
        @size -= 1
        return item[1]
      end
    end
    nil
  end

  def length
    @size
  end

  def clear
    @buckets = Array.new(@capacity) { [] }
    @size = 0
  end

  def keys
    arr = []
    @buckets.each do |item|
      item.each do |k|
        arr << k[0]
      end
    end
    arr
  end

  def values
    arr = []
    @buckets.each do |item|
      item.each do |k|
        arr << k[1]
      end
    end
    arr
  end

  def entries
    arr = []
    @buckets.each do |item|
      item.each do |k|
        arr << k
      end
    end
    arr
  end
end

test = HashMap.new

test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')

print test.length
