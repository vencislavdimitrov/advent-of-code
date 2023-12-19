input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n").map(&:chars)

def neighbours(input, x, y)
  ([-1, 0, 1] * 2).combination(2).to_a.uniq.reject do |i, j|
    x + i < 0 || y + j < 0 || x + i >= input.size || y + j >= input[0].size || [i, j] == [0, 0]
  end.map { input[x + _1][y + _2] }
end

@cache = {}
times = 0
loop do
  times += 1
  if @cache[input]
    times *= 1_000_000_000 / times
    input = @cache[input]
  else
    new_input = input.map(&:clone)
    (0...input.size).each do |i|
      (0...input[i].size).each do |j|
        n = neighbours(input, i, j)
        case input[i][j]
        when '.'
          new_input[i][j] = '|' if n.count('|') >= 3
        when '|'
          new_input[i][j] = '#' if n.count('#') >= 3
        when '#'
          new_input[i][j] = '.' unless n.count('|') >= 1 && n.count('#') >= 1
        end
      end
    end
    @cache[input] = new_input
    input = new_input
  end
  p input.flatten.count('|') * input.flatten.count('#') if times == 10
  break if times == 1_000_000_000
end

p input.flatten.count('|') * input.flatten.count('#')
