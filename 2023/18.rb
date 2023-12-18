input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n")

dir = {
  'R' => [0, 1],
  'L' => [0, -1],
  'D' => [1, 0],
  'U' => [-1, 0]
}
trench = {}
current = [0, 0]
minmax_x = [0, 0]
minmax_y = [0, 0]
step = 1
input.each do |line|
  direction, length, = line.split(' ')

  length.to_i.times do |_i|
    current[0] += dir[direction][0]
    current[1] += dir[direction][1]
    trench[current.to_s] = step
    step += 1
    minmax_x[0] = [current[0], minmax_x[0]].min
    minmax_x[1] = [current[0], minmax_x[1]].max
    minmax_y[0] = [current[1], minmax_y[0]].min
    minmax_y[1] = [current[1], minmax_y[1]].max
  end
end

enclosed = 0
(minmax_x[0]..minmax_x[1]).each do |i|
  intersects = 0
  (minmax_y[0]..minmax_y[1]).each do |j|
    if trench[[i, j].to_s]
      if trench[[i + 1, j].to_s] && trench[[i + 1, j].to_s] - trench[[i, j].to_s] == 1
        intersects += 1
      elsif trench[[i + 1, j].to_s] && trench[[i + 1, j].to_s] - trench[[i, j].to_s] == -1
        intersects -= 1
      end
    elsif intersects == -1
      enclosed += 1
    end
  end
end
p enclosed + trench.keys.size

dir = {
  '0' => [0, 1],
  '2' => [0, -1],
  '1' => [1, 0],
  '3' => [-1, 0]
}
current = [0, 0]
perimeter = 0
area = 0
input.each do |line|
  hex = line.split(' ')[-1]
  length = hex[2...-2].to_i(16)
  direction = dir[hex[-2]]
  new_current = [current[0] + length * direction[0], current[1] + length * direction[1]]

  area -= current[0] * new_current[1]
  area += current[1] * new_current[0]
  perimeter += length

  current = new_current
end
p (area + perimeter) / 2 + 1
