input = File.read(File.basename(__FILE__).gsub('rb', 'input')).split("\n")[2..]
  .map { _1.split(' ') }
  .map { name = _1.match(/\/dev\/grid\/node-x(\d+)-y(\d+)/); {
    'name':_1,
    'x': name[1].to_i,
    'y': name[2].to_i,
    'size': _2[..-1].to_i,
    'used': _3[..-1].to_i,
    'available': _4[..-1].to_i
    } }

HEIGHT = input.map { _1[:y] }.max + 1
WIDTH = input.map{ _1[:x] }.max + 1

GRID = Array.new(HEIGHT) { Array.new(WIDTH) }
input.each { |n| GRID[n[:y]][n[:x]] = n }

pairs = input.permutation(2).select { _1[:used] != 0 && _1[:used] <= _2[:available]}

puts pairs.size

empties = input.select { |n| n[:used] == 0 }

def move_to_top(empty)
  start = [empty[:y], empty[:x]]
  queue = [start]
  dist = {start => 0}

  while (pos = queue.shift)
    y, x = pos
    current_size = GRID[y][x][:size]
    return [dist[pos], x] if y == 0
    [
      ([y - 1, x] if y > 0),
      ([y + 1, x] if y + 1 < HEIGHT),
      ([y, x - 1] if x > 0),
      ([y, x + 1] if x + 1 < WIDTH),
    ].compact.each { |n|
      ny, nx = n
      next if dist.include?(n) || GRID[ny][nx][:used] > current_size
      dist[n] = dist[pos] + 1
      queue << n
    }
  end
end

puts empties.map { |empty|
  steps, x = move_to_top(empty)
  steps += WIDTH - 1 - x
  steps + 5 * (WIDTH - 2)
}.min
