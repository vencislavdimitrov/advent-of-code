input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
input = input.split("\n")

dist = {}
input.each do |line|
  cities, distance = line.split(' = ')
  city1, city2 = cities.split(' to ')
  dist[city1] ||= {}
  dist[city1][city2] = distance.to_i
  dist[city2] ||= {}
  dist[city2][city1] = distance.to_i
end

def path_dist(path, dist)
  total = 0
  path.each_cons(2) do |city1, city2|
    total += dist[city1][city2]
  end

  total
end

def dfs_min(visited, dist)
  return path_dist(visited, dist) if visited.size == dist.keys.size

  (dist.keys - visited).map { dfs_min(visited + [_1], dist) }.min
end

def dfs_max(visited, dist)
  return path_dist(visited, dist) if visited.size == dist.keys.size

  (dist.keys - visited).map { dfs_max(visited + [_1], dist) }.max
end

p dfs_min([], dist)
p dfs_max([], dist)
