require 'algorithms'
map = File.read(File.basename(__FILE__).gsub('rb', 'input')).split("\n").map(&:chars)

start = [map.index {_1.include?('S')}, map[map.index {_1.include?('S')}].index('S')]
finish = [map.index {_1.include?('E')}, map[map.index {_1.include?('E')}].index('E')]

def dijkstra(map, starts)
  dirs = [[1, 0], [0, 1], [-1, 0], [0, -1]]
  dist = Hash.new { Float::INFINITY }
  visited = {}
  unvisited = Containers::MinHeap.new
  starts.each do |start, dir|
    unvisited << [0, start, dir]
    dist[(start + dir)] = 0
  end

  until unvisited.empty?
    cost, pos, dir = unvisited.pop

    next if visited[(pos + dir)]

    visited[(pos + dir)] = true

    new_pos = [pos[0] + dir[0], pos[1] + dir[1]]
    if map[new_pos[0]][new_pos[1]] != '#' && cost + 1 < dist[(new_pos + dir)]
      dist[(new_pos + dir)] = cost + 1
      unvisited << [dist[(new_pos + dir)], new_pos, dir]
    end

    [dirs[dirs.index(dir) - 1], dirs[(dirs.index(dir) + 1) % 4]].each do |new_dir|
      if cost + 1000 < dist[(pos + new_dir)]
        dist[(pos + new_dir)] = cost + 1000
        unvisited << [dist[(pos + new_dir)], pos, new_dir]
      end
    end
  end
  dist
end

paths_from_start = dijkstra(map, [[start, [0, 1]]])
min_dist = [[0, 1], [1, 0], [0, -1], [-1, 0]].map { paths_from_start[(finish + _1)] }.min
p min_dist

paths_from_end = dijkstra(map, [[0, 1], [1, 0], [0, -1], [-1, 0]].map { [finish, _1] }.filter { map[_1[0][0] + _1[1][0]][_1[0][1] + _1[1][1]] != '#'})
paths = []
paths_from_start.each do |k, v|
  paths << k[...2] if v + paths_from_end[[k[0], k[1], -k[2], -k[3]]] == min_dist
end
p paths.uniq.size
