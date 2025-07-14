def fibonacci(n)
  result = []
  n.times do |i|
    result << if i <= 1
                i
              else
                result[i - 1] + result[i - 2]
              end
  end

  result
end

def fibonacci_rec(n, result = [])
  return result if n <= 0

  result << if result.length < 2
              result.length
            else
              result[-1] + result[-2]
            end
  fibonacci_rec(n - 1, result)
end

# Merge Sort

def buble_sort(arr_, result = [])
  if arr_.length == 1
    result << arr_[0]
    result
  elsif arr_.length == 2
    if arr_[0] > arr_[1]
      result << arr_[1]
      result << arr_[0]
    else
      result << arr_[0]
      result << arr_[1]
    end
  else
    quotient, modulus = arr_.length.divmod(2)
    buble_sort(arr_.slice(0, quotient), result)
    buble_sort(arr_.slice(quotient, arr_.length), result)

  end
end

def merge(arr_, result = [])
  if arr_.length == 1
    arr_
  else
    quotient, modulus = arr_.length.divmod(2)
    arr1 = arr_.slice(0, quotient)
    arr2 = arr_.slice(quotient, arr_.length)

    i = 0
    j = 0
    while i < arr1.length
      # print arr1[i]
      while j < arr2.length
        if arr1[i] > arr2[j]
          result <<  arr2[j]
        else
          result << arr1[i]
          break
        end

        j += 1
      end
      i += 1
      # print result
    end
    unless (arr1 - result).empty?
      (arr1 - result).each do |item|
        result << item
      end
    end
    unless (arr2 - result).empty?
      (arr2 - result).each do |item|
        result << item
      end
    end
  end

  result
end

def merge_sort_(arr_, result = [])
  return arr_ if arr_.length <= 1

  quotient, modulus = arr_.length.divmod(2)
  arr1 = buble_sort(arr_.slice(0, quotient), [])
  merge1 = merge(arr1)

  # result << merge1
  arr2 = buble_sort(arr_.slice(quotient, arr_.length), [])
  merge2 = merge(arr2)

  merge2.each do |item|
    merge1 << item
  end
  merge(merge1, [])
end

# print merge_sort([3, 2, 1, 13, 8, 5, 0, 1])
# print merge_sort([105, 79, 100, 110])
# print merge_sort([3, 2, 1, 13, 8, 5, 0, 4, 7, 9])
#

def merge_sort(arr)
  return arr if arr.length <= 1

  mid = arr.length / 2
  left = merge_sort(arr[0...mid])
  right = merge_sort(arr[mid..-1])

  sorted = []
  sorted << (left.first <= right.first ? left.shift : right.shift) until left.empty? || right.empty?

  sorted + left + right
end
print merge_sort([3, 2, 1, 13, 8, 5, 0, 4])
