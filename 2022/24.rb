input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
input = input.split("\n")

require 'set'

blizards = {}
start = nil
finish = nil
(0...input.size).each do |i|
  (0...input[i].size).each do |j|
    start ||= [i, j] if input[i][j] == '.' && i == 0
    finish ||= [i, j] if input[i][j] == '.' && i == input.size - 1
    blizards[[i, j, input[i][j]]] = [i, j] if ['>', '<', '^', 'v'].include?(input[i][j])
  end
end

def move_blizards(blizards, input)
  dirs = {
    '>' => [0, 1],
    '<' => [0, -1],
    '^' => [-1, 0],
    'v' => [1, 0]
  }
  blizards.map do |blizard, _|
    new_pos = blizard[..1].zip(dirs[blizard[2]]).map(&:sum)
    if new_pos[0] == 0
      new_pos[0] = input.size - 2
    elsif new_pos[0] == input.size - 1
      new_pos[0] = 1
    end
    if new_pos[1] == 0
      new_pos[1] = input[0].size - 2
    elsif new_pos[1] == input[0].size - 1
      new_pos[1] = 1
    end
    [[*new_pos, blizard[2]], new_pos]
  end.to_h
end

def bfs(input, blizards, start, finish)
  time = 0
  queue = Set[start]
  until queue.include?(finish)
    time += 1
    blizards = move_blizards(blizards, input)
    blizards_positions = blizards.values.uniq.to_set
    next_steps = queue.map do |current|
      [[-1, 0], [1, 0], [0, -1], [0, 1], [0, 0]].select do |d|
        new_pos = current.zip(d).map(&:sum)
        !blizards_positions.include?(new_pos) && input[new_pos[0]] && input[new_pos[0]][new_pos[1]] != '#'
      end.map { current.zip(_1).map(&:sum) }
    end.flatten(1)

    queue = Set[*next_steps]
  end
  [time, blizards]
end

first_expedition, blizards = bfs input, blizards, start, finish
p first_expedition

walk_back, blizards = bfs input, blizards, finish, start
second_expedition, = bfs input, blizards, start, finish

p first_expedition + walk_back + second_expedition
