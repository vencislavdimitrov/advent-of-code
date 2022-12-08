input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
input = input.split("\n").map { _1.chars.map(&:to_i) }

visible = (0...input.size).sum do |i|
  (0...input[i].size).sum do |j|
    [[-1, 0], [1, 0], [0, -1], [0, 1]].sum do |x, y|
      ii = i + x
      jj = j + y
      while ii >= 0 && ii < input.size && jj >= 0 && jj < input[i].size && input[ii][jj] < input[i][j]
        ii += x
        jj += y
      end

      break 1 unless ii >= 0 && ii < input.size && jj >= 0 && jj < input[i].size

      0
    end
  end
end

p visible


scores = (0...input.size).map do |i|
  (0...input[i].size).map do |j|
    score = 1
    [[-1, 0], [1, 0], [0, -1], [0, 1]].each do |x, y|
      ii = i + x
      jj = j + y
      current = 0
      while ii >= 0 && ii < input.size && jj >= 0 && jj < input[i].size
        current += 1
        break unless input[ii][jj] < input[i][j]

        ii += x
        jj += y
      end

      score *= current
    end
    score
  end
end

p scores.map(&:max).max
