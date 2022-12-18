input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
jets = input.strip

require 'set'

def shape(id, pos)
  case id
  when 0
    Set[[2, pos], [3, pos], [4, pos], [5, pos]]
  when 1
    Set[[3, pos + 2], [2, pos + 1], [3, pos + 1], [4, pos + 1], [3, pos]]
  when 2
    Set[[2, pos], [3, pos], [4, pos], [4, pos + 1], [4, pos + 2]]
  when 3
    Set[[2, pos], [2, pos + 1], [2, pos + 2], [2, pos + 3]]
  when 4
    Set[[2, pos + 1], [2, pos], [3, pos + 1], [3, pos]]
  end
end

def move_left(shape)
  if shape.map(&:first).min == 0
    shape
  else
    shape.map { [_1[0] - 1, _1[1]] }.to_set
  end
end

def move_right(shape)
  if shape.map(&:first).max == 6
    shape
  else
    shape.map { [_1[0] + 1, _1[1]] }.to_set
  end
end

def move_down(shape)
  shape.map { [_1[0], _1[1] - 1] }.to_set
end

def move_up(shape)
  shape.map { [_1[0], _1[1] + 1] }.to_set
end

cave = Set[[0, 0], [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0]]

top = 0
jet = 0

def hash(cave)
  max_height = cave.map(&:last).max
  cave.map { [_1[0], _1[1] - max_height] if max_height - _1[1] <= 10 }.to_set
end

shapes_count = 0
cave_seen = {}
t = 0
while t < 1_000_000_000_000
  shape = shape(t % 5, top + 4)

  loop do
    if jets[jet] == '<'
      shape = move_left shape
      shape = move_right shape if (shape & cave).any?
    else
      shape = move_right shape
      shape = move_left shape if (shape & cave).any?
    end

    jet = (jet + 1) % jets.size

    shape = move_down shape
    next unless (shape & cave).any?

    shape = move_up shape
    cave += shape
    top = cave.map(&:last).max

    memo_key = [jet, t % 5, hash(cave)]
    if cave_seen[memo_key] && t > 2022
      old_t, old_y = cave_seen[memo_key]
      top_diff = top - old_y
      time_diff = t - old_t
      jump = (1_000_000_000_000 - t).to_i / time_diff
      shapes_count += jump * top_diff
      t += jump * time_diff
    end

    cave_seen[memo_key] = [t, top]
    break
  end

  t += 1
  p top if t == 2022
end
p top + shapes_count
