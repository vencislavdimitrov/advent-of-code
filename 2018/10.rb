input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
scanned = input.split("\n").map { _1.scan(/-?\d+/).map(&:to_i) }

points = scanned.map { [_1[0], _1[1]] }
velocities = scanned.map { [_1[2], _1[3]] }

def print(points)
  min_width = points.map(&:first).min
  arr = Array.new(points.map(&:last).max + 1, [])

  points.each do |point|
    arr[point.last] = ' ' * (points.map(&:first).max - min_width + 1) if arr[point.last].empty?
    arr[point.last][point.first - min_width] = '#'
  end

  arr.each do |line|
    puts line
  end
end

def apply_offset(points, velocities, offset)
  points.map.with_index { |point, ind| [point[0] + offset * velocities[ind][0], point[1] + offset * velocities[ind][1]]}
end

def find_min(points, velocities)
  (9_000...11_000).map do |i|
    new_points = apply_offset points, velocities, i
    [new_points.map(&:first).max - new_points.map(&:first).min, i]
  end.min { |a, b| a[0] <=> b[0] }[1]
end

min_offset = find_min(points, velocities)
print apply_offset(points, velocities, min_offset)
p min_offset
