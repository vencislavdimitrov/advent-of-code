input = File.read('./6.input').split("\n").map { _1.split(', ').map(&:to_i) }

distances = {}
x = input.map(&:first).max + 1
y = input.map(&:last).max + 1

input.each_with_index do |point, id|
  distances[id] = []
  (0..x).each do |i|
    (0..y).each do |j|
      distances[id][j] ||= []
      distances[id][j][i] = (point.first - i).abs + (point.last - j).abs
    end
  end
end

grid = []
same_dis = []
distances.each do |id, distance|
  (0...distance.size).each do |i|
    (0...distance[i].size).each do |j|
      grid[i] ||= []
      same_dis[i] ||= []

      if grid[i][j].nil? || distances[grid[i][j]][i][j] > distance[i][j]
        grid[i][j] = id
        same_dis[i][j] = nil
      elsif distances[grid[i][j]][i][j] == distance[i][j]
        same_dis[i][j] = 1
      end
    end
  end
end

(0...grid.size).each do |i|
  (0...grid[i].size).each do |j|
    grid[i][j] = '.' unless same_dis[i][j].nil?
  end
  # p grid[i].join
end

edge_nodes = (grid[0] + grid.last + grid.map(&:first) + grid.map(&:last) + ['.']).uniq
p grid.flatten.tally.reject { |k, _| edge_nodes.include? k }.max_by { |_, v| v }[1]


grid = []
distances.each_value do |distance|
  (0...distance.size).each do |i|
    (0...distance[i].size).each do |j|
      grid[i] ||= []
      grid[i][j] ||= 0
      grid[i][j] += distance[i][j]
    end
  end
end

p grid.flatten.reject { _1 >= 10_000 }.count
