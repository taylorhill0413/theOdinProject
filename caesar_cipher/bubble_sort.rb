def bubble_sort(arr)
  result = arr
  temp = ""
  is_loop = 1

  while is_loop > 0
    is_loop = 0
    for i in (0...result.length-1)
      if result[i+1].to_i < result[i].to_i
        temp_i = result[i]
        temp = result[i+1].to_i
        result[i] = temp
        result[i+1] = temp_i
        is_loop += 1
      end
    end
  end
  result
end

print bubble_sort([4,3,78,2,0,2])