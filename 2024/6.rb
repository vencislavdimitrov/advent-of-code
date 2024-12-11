input = File.read(File.basename(__FILE__).gsub('rb', 'input')).split("\n").map(&:chars)

start = input.index { _1.include?('^') }
start = [start, input[start].index('^')]

def go(maze, x, y, dir, visited)
  if x >= maze.size || x < 0 || y >= maze[0].size || y < 0
    return visited.keys.map { [_1[0], _1[1]] }.uniq
  end

  if maze[x][y] == '#'
    newdir = case dir
    when [0, 1] then [1, 0]
    when [0, -1] then [-1, 0]
    when [1, 0] then [0, -1]
    when [-1, 0] then [0, 1]
    end
    go(maze, x - dir[0] + newdir[0], y - dir[1] + newdir[1], newdir, visited)
  else
    return -1 if visited[[x, y, dir[0], dir[1]]]
    visited[[x, y, dir[0], dir[1]]] = true
    go(maze, x + dir[0], y + dir[1], dir, visited)
  end
end

path = go(input, start[0], start[1], [-1, 0], {})
p path.count

loops = 0
(0...input.size).each do |i|
  (0...input[0].size).each do |j|
    next if input[i][j] == '#' || !path.include?([i, j])

    input[i][j] = '#'

    loops += 1 if go(input, start[0], start[1], [-1, 0], {}) == -1

    input[i][j] = '.'
  end
end

p loops
