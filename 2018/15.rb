input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
input = input.split

def neighbours(board, current, include_actors = false)
  res = []
  res << [current[0] - 1, current[1]] if current[0] > 0
  res << [current[0], current[1] - 1] if current[1] > 0
  res << [current[0], current[1] + 1] if current[1] < board[current[0]].size - 1
  res << [current[0] + 1, current[1]] if current[0] < board.size - 1

  if include_actors
    res.reject { board[_1[0]][_1[1]] == '#' }
  else
    res.select { board[_1[0]][_1[1]] == '.' }
  end
end

def bfs(board, from, to)
  next_point_options = neighbours board, [from[:x], from[:y]]
  queue = to.clone
  front = []
  visited = []
  distance = 1
  min_point = nil

  loop do
    if queue.empty?
      break if front.empty?

      queue = front.sort_by { _1[0] * 1000 + _1[1] }.uniq
      front = []
      distance += 1
    end

    current = queue.shift
    if next_point_options.include?(current)
      min_point = current
      break
    end

    visited << current

    neighbours(board, current).each do |neighbour|
      front << neighbour unless visited.include?(neighbour)
    end
  end
  [distance, to, min_point] if min_point
end

def move(board, actors, current)
  targets = actors.reject { _1[:type] == current[:type] || _1[:hp] <= 0 }
  target_neighbours = targets.map { neighbours(board, [_1[:x], _1[:y]]) }.uniq
  next_steps = target_neighbours.map { bfs(board, current, _1) }.compact.sort

  return false if next_steps.empty?

  step = next_steps.first.last
  board[current[:x]][current[:y]] = '.'
  board[step[0]][step[1]] = current[:type]
  current[:x] = step[0]
  current[:y] = step[1]

  true
end

def attack(board, actors, current)
  neighbours = neighbours board, [current[:x], current[:y]], true
  target = actors.select { _1[:type] != current[:type] && neighbours.include?([_1[:x], _1[:y]]) && _1[:hp].positive? }.min_by { [_1[:hp], _1[:x] * 1000 + _1[:y]] }

  if target
    target[:hp] -= current[:power]
    board[target[:x]][target[:y]] = '.' if target[:hp] <= 0
    true
  else
    false
  end
end

def calculate(board, elf_power)
  actors = []
  (0...board.size).each do |i|
    (0...board[i].size).each do |j|
      if ['G', 'E'].include?(board[i][j])
        actors << { type: board[i][j], x: i, y: j, hp: 200, power: board[i][j] == 'E' ? elf_power : 3 }
      end
    end
  end

  round = 0
  loop do
    combat_end = false

    actors.sort_by { [_1[:x], _1[:y]] }.each do |current|
      next if current[:hp] <= 0

      combat_end = actors.select { _1[:hp].positive? }.map { _1[:type] }.uniq.one?
      break if combat_end

      move(board, actors, current) && attack(board, actors, current) unless attack(board, actors, current)
    end

    break if combat_end

    round += 1
  end

  [round * actors.select { _1[:hp].positive? }.sum { _1[:hp] }, actors]
end

p calculate(input.map(&:clone), 3)[0]

(34...40).each do |elf_power|
  elf_count = input.join.count('E')

  result, actors = calculate input.map(&:clone), elf_power

  if actors.select { _1[:hp].positive? }.map { _1[:type] }.uniq.one? && actors.count { _1[:type] == 'E' && _1[:hp].positive? } == elf_count
    p result
    break
  end
end
