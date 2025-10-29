input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n").map(&:chars)

pois = {}
input.each_with_index do |line, i|
  line.each_with_index do |c, j|
    if c != '#' && c != '.'
      pois[c] = [i, j]
    end
  end
end

def bfs(input, start, finish)
  queue = [[start, 0]]
  visited = {}
  until queue.empty?
    current, steps = queue.shift

    next if visited[current]
    visited[current] = true

    return steps if current == finish

    [
      [current[0]-1, current[1]],
      [current[0]+1, current[1]],
      [current[0], current[1]-1],
      [current[0], current[1]+1]
    ].filter {
      _1[0] >= 0 && _1[0] < input.size &&
      _1[1] >= 0 && _1[1] < input[0].size &&
      input[_1[0]][_1[1]] != '#' && !visited[_1]
    }.each do |child|
      queue << [child, steps + 1]
    end
  end
end

paths = {}
pois.keys.combination(2).each do |from, to|
  path = bfs(input, pois[from], pois[to])
  paths[[from, to]] = path
  paths[[to, from]] = path
end

p (pois.keys - ['0']).permutation.map { (['0'] + _1).each_cons(2).map { |from, to| paths[[from, to]] }.sum }.min

p (pois.keys - ['0']).permutation.map { (['0'] + _1 + ['0']).each_cons(2).map { |from, to| paths[[from, to]] }.sum }.min
