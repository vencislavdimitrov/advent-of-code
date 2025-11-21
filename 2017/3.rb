input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.to_i

def calc_diff(grid, x, y, diff_x, diff_y)
  case [diff_x, diff_y]
  when [1, 0]
    if grid[x][y - 1] == 0
      return [0, -1]
    end
  when [0, -1]
    if grid[x - 1][y] == 0
      return [-1, 0]
    end
  when [-1, 0]
    if grid[x][y + 1] == 0
      return [0, 1]
    end
  when [0, 1]
    if grid[x + 1][y] == 0
      return [1, 0]
    end
  end
  [diff_x, diff_y]
end

grid_size = Math.sqrt(input).ceil
grid = Array.new(grid_size + 2) { Array.new(grid_size + 2, 0) }
x, y = grid_size/2, grid_size/2
diff_x, diff_y = 1, 0
(1..input).each do |n|
  grid[x][y] = n
  x += diff_x
  y += diff_y
  diff_x, diff_y = calc_diff(grid, x, y, diff_x, diff_y)
end
p (x - grid_size/2).abs + (y - grid_size/2).abs - 1

grid = Array.new(grid_size) { Array.new(grid_size, 0) }
x, y = grid_size/2, grid_size/2
diff_x, diff_y = 1, 0
grid[x][y] = 1
(1..).each do |n|
  grid[x][y] = [
    [-1, -1], [-1, 0], [-1, 1],
    [0, -1], [0, 0], [0, 1],
    [1, -1], [1, 0], [1, 1],
  ].map { grid[x + _1][y + _2] }.sum
  if grid[x][y] > input
    p grid[x][y]
    exit
  end

  x += diff_x
  y += diff_y
  diff_x, diff_y = calc_diff(grid, x, y, diff_x, diff_y)
end
