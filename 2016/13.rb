input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.to_i

@input = input
def wall(x, y)
  (x*x + 3*x + 2*x*y + y + y*y + @input).to_s(2).count('1').odd?
end

max_x = 100
max_y = 100
maze = []
(0..max_x).each do |x|
  line = []
  (0..max_y).each do |y|
    line << wall(x, y)
  end
  maze << line
end

def bfs(maze, start, finish)
  queue = [[start, 0]]
  visited = []

  until queue.empty?
    current, dist = queue.shift
    return dist if current == finish

    next if visited.include?(current)

    visited << current
    x, y = current
    [[-1, 0], [1, 0], [0, -1], [0, 1]].each do |x_i, y_i|
      if x + x_i >= 0 && y + y_i >= 0 && x + x_i < maze.size && y + y_i < maze[0].size && maze[x + x_i][y + y_i] == false
        queue << [[x + x_i, y + y_i], dist + 1]
      end
    end
  end
end

p bfs(maze, [1, 1], [31, 39])

def bfs_max_dist(maze, start, max_dist)
  queue = [[start, 0]]
  visited = []

  until queue.empty?
    current, dist = queue.shift
    return visited.size if dist == max_dist

    next if visited.include?(current)

    visited << current
    x, y = current
    [[-1, 0], [1, 0], [0, -1], [0, 1]].each do |x_i, y_i|
      if x + x_i >= 0 && y + y_i >= 0 && x + x_i < maze.size && y + y_i < maze[0].size && maze[x + x_i][y + y_i] == false
        queue << [[x + x_i, y + y_i], dist + 1]
      end
    end
  end
end

p bfs_max_dist(maze, [1, 1], 51)
