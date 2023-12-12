input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n").map(&:chars)

def neighbours(input, x, y)
  res = []
  [-1, 0, 1].each do |i|
    [-1, 0, 1].each do |j|
      next if i == 0 && j == 0

      res << input[x + i][y + j] if x + i >= 0 && x + i < input.size && y + j >= 0 && y + j < input.size
    end
  end
  res.count('#')
end

100.times do
  new_input = input.map(&:clone)
  (0...input.size).each do |i|
    (0...input[i].size).each do |j|
      n = neighbours(input, i, j)
      if ![2, 3].include?(n) && input[i][j] == '#'
        new_input[i][j] = '.'
      elsif n == 3 && input[i][j] == '.'
        new_input[i][j] = '#'
      end
    end
  end
  new_input[0][0] = '#'
  new_input[0][-1] = '#'
  new_input[-1][0] = '#'
  new_input[-1][-1] = '#'
  input = new_input
  # input.map { puts _1.join }
  # puts ''
end

p input.map(&:join).join.count('#')
