require 'algorithms'
input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n")

floors = [[], [], [], []]

regex = /a (.*?) (generator|microchip)/

input.each_with_index do |line, floor_index|
  next if line.include?('nothing relevant')

  line.scan(regex).each do |match|
    material, thing_type = match
    if thing_type == 'microchip'
        material = material.split('-')[0]
    end
    floors[floor_index] << material + ' ' + thing_type[0]
  end
end

def can_be_at_same_level(items)
  micros, gens = items.partition { _1[-1] }
  return true if gens.empty?
  micros.all? do |m|
    gens.any? { |g| g[-1] == m[-1] }
  end
end

init_state = floors.map(&:sort)

def dijkstra(init_state)
  all_items = init_state.map(&:size).sum
  init = [0, init_state]
  queue = Containers::MinHeap.new
  queue << [0, init]
  dists = Hash.new(Float::INFINITY)
  dists[init] = 0

  until queue.empty?
    _, current = queue.pop
    level, state = current
    dist = dists[current]
    items = state[level]

    return dist if level == 3 && items.size == all_items

    moves = items.map { |e| [e] } + items.combination(2).to_a
    possible_moves = moves.select do |move|
      old_level = items.dup - move
      can_be_at_same_level(old_level)
    end

    [-1, 1].each do |dir|
      l = level + dir

      next if l < 0 || l > 3

      possible_moves.each do |move|
        new_level = state[l] + move
        if can_be_at_same_level(new_level)
          new_state = state.map(&:dup)
          new_state[level] = items.dup - move
          new_state[l] = new_level.sort
          step = [l, new_state.freeze].freeze
          new_dist = dist + 1
          if dists[step] > new_dist
            dists[step] = new_dist
            queue << [(new_dist) - new_state[3].size * 10, step]
          end
        end
      end
    end
  end
end

p dijkstra(init_state)

init_state[0] += ["elerium g", "elerium m", "dilithium g", "dilithium m"]
p dijkstra(init_state)
