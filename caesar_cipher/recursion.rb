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

print fibonacci_rec(3)
