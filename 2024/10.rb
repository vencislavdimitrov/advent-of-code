input = File.read(File.basename(__FILE__).gsub('rb', 'input')).split("\n").map { _1.chars.map(&:to_i) }

def score(input, start, rating)
  queue = [[0, start]]
  visited = {}

  res = 0
  until queue.empty?
    height, pos = queue.pop
    visited[pos] = true

    if input[pos[0]][pos[1]] == 9
      res += 1
    else
      adj = []
      adj << [pos[0] - 1, pos[1]] if pos[0] - 1 >= 0
      adj << [pos[0], pos[1] - 1] if pos[1] - 1 >= 0
      adj << [pos[0] + 1, pos[1]] if pos[0] + 1 < input.size
      adj << [pos[0], pos[1] + 1] if pos[1] + 1 < input[0].size

      queue += adj.filter { (rating || !visited[_1]) && input[_1[0]][_1[1]] == height + 1 }.map { [height + 1, _1] }
    end
  end
  res
end

starts = []
(0...input.size).each do |i|
  (0...input[0].size).each do |j|
    starts << [i, j] if input[i][j] == 0
  end
end

p starts.map { score(input, _1, false) }.sum

p starts.map { score(input, _1, true) }.sum
