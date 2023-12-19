require 'algorithms'
input = File.read(File.basename(__FILE__).gsub('rb', 'input')).split("\n")
depth = input[0].split(' ')[1].to_i
target = input[1].split(' ')[1].split(',').map(&:to_i)

geo_index = [[]] * target[0]
(0..target[0]).each do |i|
  geo_index[i] = [0] * target[1]
  (0..target[1]).each do |j|
    geo_index[i][j] = if i == target[0] && j == target[1]
                        0
                      elsif i == 0
                        (48_271 * j) % 20_183
                      elsif j == 0
                        (16_807 * i) % 20_183
                      else
                        ((geo_index[i - 1][j] + depth) * (geo_index[i][j - 1] + depth)) % 20_183
                      end
  end
end

p geo_index.map { _1.map { |x| (x + depth) % 20_183 % 3 }.sum }.sum

geo_index = [[]] * (50 + target[0])
(0..50 + target[0]).each do |i|
  geo_index[i] = [0] * target[1]
  (0..50 + target[1]).each do |j|
    geo_index[i][j] = if i == target[0] && j == target[1]
                        0
                      elsif i == 0
                        (48_271 * j) % 20_183
                      elsif j == 0
                        (16_807 * i) % 20_183
                      else
                        ((geo_index[i - 1][j] + depth) * (geo_index[i][j - 1] + depth)) % 20_183
                      end
  end
end
map = geo_index.map { _1.map { |x| (x + depth) % 20_183 % 3 } }

def dijkstra(input, start, finish)
  dist = Hash.new { Float::INFINITY }
  tools = [
    %i[torch climbing_gear],
    %i[climbing_gear neither],
    %i[torch neither]
  ]
  tool = :torch
  unvisited = Containers::MinHeap.new
  unvisited << [0, start, tool]
  dist[(start + [tool]).to_s] = 0

  until unvisited.empty?
    cost, current, tool = unvisited.pop

    return cost if current == finish && tool == :torch

    [[0, 1], [1, 0], [0, -1], [-1, 0]].each do |new_dir|
      step = [current[0] + new_dir[0], current[1] + new_dir[1]]
      next unless step[0] >= 0 && step[0] < input.size && step[1] >= 0 && step[1] < input[0].size

      if tools[input[step[0]][step[1]]].include?(tool) && (1 + cost < dist[(step + [tool]).to_s])
        dist[(step + [tool]).to_s] = 1 + cost
        unvisited << [dist[(step + [tool]).to_s], step, tool]
      end
    end

    tools[input[current[0]][current[1]]].each do |new_tool|
      next if new_tool == tool

      if 7 + cost < dist[(current + [new_tool]).to_s]
        dist[(current + [new_tool]).to_s] = 7 + cost
        unvisited << [dist[(current + [new_tool]).to_s], current, new_tool]
      end
    end
  end
end

p dijkstra(map, [0, 0], target)
