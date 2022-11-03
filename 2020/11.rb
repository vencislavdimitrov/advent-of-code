input_file = File.read('./11.input').split

def count_adj1(input, x, y)
  adj_seats = []
  adj_seats << input[x - 1][y] if x > 0
  adj_seats << input[x + 1][y] if x < input.size - 1
  adj_seats << input[x][y - 1] if y > 0
  adj_seats << input[x][y + 1] if y < input[x].size - 1
  adj_seats << input[x - 1][y - 1] if x > 0 && y > 0
  adj_seats << input[x - 1][y + 1] if x > 0 && y < input[x].size - 1
  adj_seats << input[x + 1][y - 1] if x < input.size - 1 && y > 0
  adj_seats << input[x + 1][y + 1] if x < input.size - 1 && y < input[x].size - 1

  adj_seats.count '#'
end

def count_seats(input)
  input.inject(0) { |sum, line| sum + line.count('#') }
end

input1 = input_file.map(&:dup)
input2 = input_file.map(&:dup)
loop do
  input1 = input2.map(&:dup)
  (0...input1.size).each do |i|
    (0...input1[i].size).each do |j|
      input2[i][j] = '#' if input1[i][j] == 'L' && count_adj1(input1, i, j).zero?
    end
  end
  input1 = input2.map(&:dup)
  (0...input1.size).each do |i|
    (0..input1[i].size - 1).each do |j|
      input2[i][j] = 'L' if input1[i][j] == '#' && count_adj1(input1, i, j) >= 4
    end
  end
  break if count_seats(input1) == count_seats(input2)
end

pp count_seats(input1)

def count_adj2(input, x, y)
  adj_seats = []
  (1...input.size).each do |i|
    if x - i >= 0 && input[x - i][y] != '.'
      adj_seats << input[x - i][y]
      break
    end
  end
  (1...input.size).each do |i|
    if x + i < input.size && input[x + i][y] != '.'
      adj_seats << input[x + i][y]
      break
    end
  end
  (1...input.size).each do |i|
    if y - i >= 0 && input[x][y - i] != '.'
      adj_seats << input[x][y - i]
      break
    end
  end
  (1...input.size).each do |i|
    if y + i < input[x].size && input[x][y + i] != '.'
      adj_seats << input[x][y + i]
      break
    end
  end
  (1...input.size).each do |i|
    if x - i >= 0 && y - i >= 0 && input[x - i][y - i] != '.'
      adj_seats << input[x - i][y - i]
      break
    end
  end
  (1...input.size).each do |i|
    if x - i >= 0 && y + i < input[x].size && input[x - i][y + i] != '.'
      adj_seats << input[x - i][y + i]
      break
    end
  end
  (1...input.size).each do |i|
    if x + i < input.size && y + i < input[x].size && input[x + i][y + i] != '.'
      adj_seats << input[x + i][y + i]
      break
    end
  end
  (1...input.size).each do |i|
    if x + i < input.size && y - i >= 0 && input[x + i][y - i] != '.'
      adj_seats << input[x + i][y - i]
      break
    end
  end

  adj_seats.count('#')
end

input1 = input_file.map(&:dup)
input2 = input_file.map(&:dup)
loop do
  input1 = input2.map(&:dup)
  (0...input1.size).each do |i|
    (0..input1[i].size - 1).each do |j|
      input2[i][j] = '#' if input1[i][j] == 'L' && count_adj2(input1, i, j).zero?
    end
  end
  input1 = input2.map(&:dup)
  (0...input1.size).each do |i|
    (0...input1[i].size).each do |j|
      input2[i][j] = 'L' if input1[i][j] == '#' && count_adj2(input1, i, j) >= 5
    end
  end
  break if count_seats(input1) == count_seats(input2)
end

pp count_seats(input1)
