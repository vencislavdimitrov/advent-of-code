require 'algorithms'
input = File.read(File.basename(__FILE__).gsub('rb', 'input')).split("\n").map { _1.split(',').map(&:to_i) }

start = [0, 0]
finish = [70, 70]

def dijkstra(input, start, finish)
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
      step = [current[0] + new_dir[0], current[1] + new_dir[1]]
      next unless step[0] >= 0 && step[0] <= 70 && step[1] >= 0 && step[1] <= 70 && !input.include?(step)

      if 1 + cost < dist[(step + new_dir).to_s]
        dist[(step + new_dir).to_s] = 1 + cost
        unvisited << [dist[(step + new_dir).to_s], step, new_dir]
      end
    end
  end
  [[0, 1], [1, 0], [0, -1], [-1, 0]].map { dist[(finish + _1).to_s] }.min
end

p dijkstra(input.first(1024), start, finish)

min = 1024
max = input.size - 1
i = min + (max - min) / 2
while min <= max
  dist = dijkstra(input.first(i), start, finish)
  if dist < Float::INFINITY
    min = i + 1
  else
    max = i - 1
  end
  i = min + (max - min) / 2
end
puts input[i].join(',')
