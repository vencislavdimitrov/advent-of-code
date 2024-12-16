map, directions = File.read(File.basename(__FILE__).gsub('rb', 'input')).split("\n\n")

map = map.split("\n").map(&:chars)
double_map = map.map(&:clone).map { |line| line.map {
  case _1
  when '#' then ['#', '#']
  when 'O' then ['[', ']']
  when '.' then ['.', '.']
  when '@' then ['@', '.']
  end
}.flatten}
directions = directions.strip

def move(robot, dir, map)
  new_robot = [robot[0] + dir[0], robot[1] + dir[1]]
  if map[new_robot[0]][new_robot[1]] == '.'
    map[new_robot[0]][new_robot[1]] = '@'
    map[robot[0]][robot[1]] = '.'
    return new_robot
  elsif map[new_robot[0]][new_robot[1]] == 'O'
    new_new_robot = [new_robot[0] + dir[0], new_robot[1] + dir[1]]
    while map[new_new_robot[0]][new_new_robot[1]] == 'O'
      new_new_robot = [new_new_robot[0] + dir[0], new_new_robot[1] + dir[1]]
    end
    if map[new_new_robot[0]][new_new_robot[1]] == '.'
      map[new_robot[0]][new_robot[1]] = '@'
      map[new_new_robot[0]][new_new_robot[1]] = 'O'
      map[robot[0]][robot[1]] = '.'
      return new_robot
    end
  end
  robot
end

def can_move?(pos, dir, map)
  positions = [pos]
  c = map[pos[0]][pos[1]]
  if dir[0] != 0
    if c == '['
      positions << ([pos[0], pos[1] + 1])
    elsif c == ']'
      positions << ([pos[0], pos[1] - 1])
    end
  end

  positions.each do |new_pos|
    c = map[new_pos[0]][new_pos[1]]
    nx, ny = new_pos[0] + dir[0], new_pos[1] + dir[1]
    dest = map[nx][ny]
    if dest == '.'
      next
    elsif dest == '#'
      return false
    elsif '[]'.include?(dest)
      if !can_move?([nx, ny], dir, map)
        return false
      end
    end
  end
  return true
end

def move2(pos, dir, map)
  if !can_move?(pos, dir, map)
    return pos
  end

  positions = [pos]
  c = map[pos[0]][pos[1]]
  if dir[0] != 0
    if c == '['
      positions.append([pos[0], pos[1] + 1])
    elsif c == ']'
      positions.append([pos[0], pos[1] - 1])
    end
  end

  positions.each do |new_pos|
    c = map[new_pos[0]][new_pos[1]]
    nx, ny = new_pos[0] + dir[0], new_pos[1] + dir[1]
    dest = map[nx][ny]
    if dest == '.'
      map[new_pos[0]][new_pos[1]] = '.'
      map[nx][ny] = c
    elsif '[]'.include?(dest)
      move2([nx, ny], dir, map)
      map[new_pos[0]][new_pos[1]] = '.'
      map[nx][ny] = c
    end
  end
  return [pos[0] + dir[0], pos[1] + dir[1]]
end

def sum_gps(map, directions, move)
  robot = [map.index { _1.include?('@') }, map[map.index { _1.include?('@') }].index('@')]
  directions.chars.each do |dir|
    case dir
    when '^'
      robot = move.call(robot, [-1, 0], map)
    when 'v'
      robot = move.call(robot, [1, 0], map)
    when '>'
      robot = move.call(robot, [0, 1], map)
    when '<'
      robot = move.call(robot, [0, -1], map)
    end
  end

  sum = 0
  (0...map.size).each do |i|
    (0...map[0].size).each do |j|
      sum += i * 100 + j if '[O'.include?(map[i][j])
    end
  end
  sum
end

p sum_gps(map, directions, method(:move))
p sum_gps(double_map, directions, method(:move2))
