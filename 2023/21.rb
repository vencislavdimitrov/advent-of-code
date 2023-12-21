input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n").map(&:chars)

start = [input.index { _1.include?('S') }, input[input.index { _1.include?('S') }].index('S')]

def bfs(input, steps)
  return steps.last.count if steps.size > 64

  steps << []
  steps[-2].each do |c|
    [[0, 1], [0, -1], [1, 0], [-1, 0]].each do |dir|
      new_c = [c[0] + dir[0], c[1] + dir[1]]
      if new_c[0] >= input.size || new_c[0] < 0 ||
         new_c[1] > input[0].size || new_c[1] < 0 ||
         input[new_c[0]][new_c[1]] == '#' ||
         steps[-1].include?(new_c)
        next
      end

      steps[-1] << new_c
    end
  end
  bfs(input, steps)
end
p bfs(input, [[start]])

steps_memo = {}
stack = [start + [0, 0, 0]]
until stack.empty?
  x, y, map_x, map_y, steps = stack.shift
  if x < 0
    map_x -= 1
    x += input.size
  elsif x >= input.size
    map_x += 1
    x -= input.size
  end
  if y < 0
    map_y -= 1
    y += input[0].size
  elsif y >= input[0].size
    map_y += 1
    y -= input[0].size
  end

  next if input[x][y] == '#' || steps_memo.key?([x, y, map_x, map_y])
  next if map_x < -1 || map_x > 1 || map_y < -1 || map_y > 1

  steps_memo[[x, y, map_x, map_y]] = steps

  [[0, 1], [0, -1], [1, 0], [-1, 0]].each do |dir|
    stack << [x + dir[0], y + dir[1], map_x, map_y, steps + 1]
  end
end

@memo = {}
def repeat(steps, map_corner, input)
  total_steps = 26_501_365
  return @memo[[steps, map_corner, total_steps]] if @memo.key?([steps, map_corner, total_steps])

  res = 0
  (1..(total_steps - steps) / input.size).each do |i|
    next unless steps + input.size * i <= total_steps && (steps + input.size * i).odd?

    res += 1
    res += i unless map_corner
  end
  @memo[[steps, map_corner, total_steps]] = res
  res
end

res = 0
(0...input.size).each do |i|
  (0...input[0].size).each do |j|
    next unless steps_memo.key?([i, j, 0, 0])

    (-1..1).each do |map_x|
      (-1..1).each do |map_y|
        steps = steps_memo[[i, j, map_x, map_y]]
        res += 1 if steps.odd?

        next if map_x == 0 && map_y == 0

        res += repeat(steps, map_x == 0 || map_y == 0, input)
      end
    end
  end
end

p res
