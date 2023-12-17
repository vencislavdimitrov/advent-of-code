require 'algorithms'
input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n").map { _1.chars.map(&:to_i) }

def dijkstra(input, start, finish, min_steps, max_steps)
  dist = Hash.new { Float::INFINITY }
  visited = {}
  unvisited = Containers::MinHeap.new
  unvisited << [0, start, []]
  dist[(start + []).to_s] = 0

  until unvisited.empty?
    cost, current, dir = unvisited.pop

    next if visited[(current + dir).to_s]

    visited[(current + dir).to_s] = true

    [[0, 1], [1, 0], [0, -1], [-1, 0]].each do |new_dir|
      new_cost = 0

      if new_dir == dir || (new_dir[0] == dir[0] && new_dir[1] != dir[1]) || (new_dir[0] != dir[0] && new_dir[1] == dir[1])
        next
      end

      (1..max_steps).each do |stretch|
        step = [current[0] + new_dir[0] * stretch, current[1] + new_dir[1] * stretch]
        next unless step[0] >= 0 && step[0] < input.size && step[1] >= 0 && step[1] < input[0].size

        new_cost += input[step[0]][step[1]]
        next if stretch < min_steps

        if new_cost + cost < dist[(step + new_dir).to_s]
          dist[(step + new_dir).to_s] = new_cost + cost
          unvisited << [dist[(step + new_dir).to_s], step, new_dir]
        end
      end
    end
  end
  [[0, 1], [1, 0], [0, -1], [-1, 0]].map { dist[(finish + _1).to_s] }.min
end

p dijkstra(input, [0, 0], [input.size - 1, input[0].size - 1], 1, 3)
p dijkstra(input, [0, 0], [input.size - 1, input[0].size - 1], 4, 10)
