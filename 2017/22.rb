input = File.read(File.basename(__FILE__).gsub('rb', 'input')).split("\n").map(&:chars)

directions = [
  [-1, 0],
  [0, 1],
  [1, 0],
  [0, -1],
]

carrier = [input.size/2, input[0].size/2]
direction = 0
bursts = 0
infected = Set.new
input.each_with_index do |line, i|
  line.each_with_index do |c, j|
    infected.add([i, j]) if c == '#'
  end
end

10000.times do
  if infected.include?(carrier)
    direction = (direction + 1) % directions.size
    infected.delete(carrier)
  else
    direction = (direction - 1) % directions.size
    infected.add(carrier)
    bursts += 1
  end
  carrier = [carrier[0] + directions[direction][0], carrier[1] + directions[direction][1]]
end
p bursts

carrier = [input.size/2, input[0].size/2]
direction = 0
bursts = 0
infected = Hash.new
input.each_with_index do |line, i|
  line.each_with_index do |c, j|
    infected[[i, j]] = :i if c == '#'
  end
end
10000000.times do
  case infected[carrier]
  when :i
    direction = (direction + 1) % directions.size
    infected[carrier] = :f
  when :w
    infected[carrier] = :i
    bursts += 1
  when :f
    direction = (direction + 2) % directions.size
    infected.delete(carrier)
  else
    direction = (direction - 1) % directions.size
    infected[carrier] = :w
  end
  carrier = [carrier[0] + directions[direction][0], carrier[1] + directions[direction][1]]
end
p bursts
