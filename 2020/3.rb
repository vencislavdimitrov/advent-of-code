input_file = File.read('./3.input').split

def calculate_slope(right, down, input_file)
  pos_right = 0
  pos_down = 0
  trees = 0
  while pos_down < input_file.size - 1
    pos_right += right
    pos_down += down
    trees += 1 if input_file[pos_down][pos_right % input_file[pos_down].size] == '#'
  end

  trees
end

pp calculate_slope(3, 1, input_file)

pp calculate_slope(1, 1, input_file) *
   calculate_slope(3, 1, input_file) *
   calculate_slope(5, 1, input_file) *
   calculate_slope(7, 1, input_file) *
   calculate_slope(1, 2, input_file)
