input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
input = input.split("\n")

grid = {}
grid2 = {}
head = [0, 0]
tails = [[0, 0]] * 9

def move_tail(head, tail)
  if (head[0] - tail[0]).abs >= 2 && (head[1] - tail[1]).abs >= 2
    [tail[0] < head[0] ? head[0] - 1 : head[0] + 1, tail[1] < head[1] ? head[1] - 1 : head[1] + 1]
  elsif (head[0] - tail[0]).abs >= 2
    [tail[0] < head[0] ? head[0] - 1 : head[0] + 1, head[1]]
  elsif (head[1] - tail[1]).abs >= 2
    [head[0], tail[1] < head[1] ? head[1] - 1 : head[1] + 1]
  else
    tail
  end
end

input.each do |line|
  direction, steps = line.split(' ')
  steps.to_i.times do
    case direction
    when 'U'
      head[0] -= 1
    when 'D'
      head[0] += 1
    when 'L'
      head[1] -= 1
    when 'R'
      head[1] += 1
    end

    tails[0] = move_tail head, tails.first
    (1...tails.size).each do |i|
      tails[i] = move_tail tails[i - 1], tails[i]
    end

    grid[tails.first] = '#'
    grid2[tails.last] = '#'
  end
end

p grid.count
p grid2.count
