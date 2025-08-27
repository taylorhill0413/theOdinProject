# arr = {}

# arr['rank'] << [[0, 1], [0, 2], [0, 3]]
# print arr
# arr = []

# (0..7).each do |c|
#   arr << [c, -c]
# end

# print arr"
#
arr = [[0, 1], [0, 2], [0, 3]]
move = [0, 4]
result = arr.find { |pos| pos[0] == move[0] && pos[1] == move[1] }.nil?
print result
