input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n")

def forkable(input, x, y)
  return false if input[x][y] != '@'
  [
    [-1, 0],
    [-1, -1],
    [0, -1],
    [1, -1],
    [1, 0],
    [1, 1],
    [0, 1],
    [-1, 1],
  ].filter { x + _1[0] >= 0 && y + _1[1] >= 0 && x + _1[0] < input.size && y + _1[1] < input[0].size }
  .count { input[x+_1[0]][y+_1[1]] == '@'} < 4
end

count = 0
(0...input.size).each do |i|
  (0...input[i].size).each do |j|
    count += 1 if forkable(input, i, j)
  end
end
p count

removed = 0
loop do
  new_input = input.map(&:dup)
  (0...input.size).each do |i|
    (0...input[i].size).each do |j|
      if forkable(input, i, j)
        removed += 1
        new_input[i][j] = '.'
      end
    end
  end
  break if input.sum { _1.count('@') } == new_input.sum { _1.count('@') }

  input = new_input
end
p removed
