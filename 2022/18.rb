input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
input = input.split("\n").map { _1.split(',').map(&:to_i) }

def adj_cubes(cube)
  [
    [cube[0] + 1, cube[1], cube[2]],
    [cube[0] - 1, cube[1], cube[2]],
    [cube[0], cube[1] + 1, cube[2]],
    [cube[0], cube[1] - 1, cube[2]],
    [cube[0], cube[1], cube[2] + 1],
    [cube[0], cube[1], cube[2] - 1]
  ]
end

connected_cubes = {}
surface = 0

input.each do |cube|
  surface += 6
  adj_cubes(cube).each do |adj|
    surface -= 2 if connected_cubes[adj]
    connected_cubes[cube] = true
  end
end

p surface

all_cubes = {}
(0..25).to_a.repeated_permutation(3).each do |k|
  all_cubes[k] = true
end

empty_cubes = all_cubes.keep_if { !connected_cubes.key? _1 }
queue = [[0, 0, 0]]

until queue.empty?
  cube = queue.shift
  if empty_cubes[cube]
    empty_cubes[cube] = false
    queue += adj_cubes(cube)
  end
end

empty_cubes.each do |cube, present|
  next unless present

  surface += 6
  adj_cubes(cube).each do |adj|
    surface -= 2 if connected_cubes[adj]
    connected_cubes[cube] = true
  end
end

p surface
