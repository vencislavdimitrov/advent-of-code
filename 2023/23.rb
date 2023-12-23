input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n").map(&:chars)

start = [0, 1]
finish = [input.size-1, input[0].size-2]
def dfs(input, current, finish, visited)
  return visited.size if current == finish

  next_steps = []
  [[0, 1], [0, -1], [1, 0], [-1, 0]].each do |dir|
    next_step = [current[0] + dir[0], current[1] + dir[1]]
    next if input[next_step[0]][next_step[1]] == '#'
    next if visited.include?(next_step)

    case input[current[0]][current[1]]
    when '>'
      next_steps << next_step if dir == [0, 1]
    when '<'
      next_steps << next_step if dir == [0, -1]
    when '^'
      next_steps << next_step if dir == [-1, 0]
    when 'v'
      next_steps << next_step if dir == [1, 0]
    else
      next_steps << next_step
    end

  end
  return next_steps.map { dfs(input, _1, finish, visited + [_1]) }.max || 0
end

p dfs(input, start, finish, [])


vertices = [start, finish]

(0...input.size).each do |i|
  (0...input.size).each do |j|
    next if input[i][j] == '#'

    next_steps = []
    [[0, 1], [0, -1], [1, 0], [-1, 0]].each do |dir|
      next_step = [i + dir[0], j + dir[1]]
      next if next_step[0] < 0 || next_step[0] >= input.size || next_step[1] < 0 || next_step[1] >= input[0].size
      next_steps << next_step if input[next_step[0]][next_step[1]] != '#'
    end
    vertices << [i, j] if next_steps.size > 2
  end
end

@distances = {}
@edges = {}
vertices.each do |v|
  distance = 0
  visited = {}
  queue = [[v, 0]]

  until queue.empty?
    current, distance = queue.shift

    if current != v && vertices.include?(current)
      @distances[[v, current]] = distance
      @edges[v] ||= []
      @edges[v] << current
      next
    end

    visited[current] = true

    next_steps = []
    [[0, 1], [0, -1], [1, 0], [-1, 0]].each do |dir|
      next_step = [current[0] + dir[0], current[1] + dir[1]]
      next if next_step[0] < 0 || next_step[0] >= input.size || next_step[1] < 0 || next_step[1] >= input[0].size
      next if visited[next_step]
      next_steps << next_step if input[next_step[0]][next_step[1]] != '#'
    end

    next_steps.each do |step|
      queue << [step, distance + 1]
    end
  end
end


@visited = {}
@max_dist = 0
def dfs(start, finish, dist)
  return if @visited[start]

  @visited[start] = true

  @max_dist = [@max_dist, dist].max if start == finish

  @edges[start].each do |step|
    dfs(step, finish, @distances[[start, step]] + dist)
  end
  @visited[start] = false
end

dfs(start, finish, 0)
p @max_dist
