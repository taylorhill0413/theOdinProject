def stock_picker(arr)
  result = []
  temp_min = arr[0]
  temp_min_index = 0
  temp_max = 0
  temp_max_index = 0
  arr.each_with_index do |item, index|
    if temp_min > item
      temp_min = item
      temp_min_index = index
      (index+1).upto(arr.length) do |i|
        if temp_max < (arr[i].to_i - temp_min)
          temp_max = arr[i].to_i - temp_min
          temp_max_index = i
        end
      end
      if temp_max_index > temp_min_index
        result.push(temp_min_index, temp_max_index)
      end
      #print [temp_min_index, temp_max_index]
    end
  end
  result
end

print stock_picker([17,3,6,9,15,8,6,1,10])