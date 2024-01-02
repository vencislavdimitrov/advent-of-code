require 'set'

input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n")
input = input.map { _1.sub(' @', ',')}.map { _1.split(', ').map(&:to_i) }.sort

def intersection_point(p1, p2, n1, n2)
  p1End = [p1[0] + n1[0], p1[1] + n1[1]]
  p2End = [p2[0] + n2[0], p2[1] + n2[1]]

  m1 = (p1End[1] - p1[1]).to_f / (p1End[0] - p1[0])
  m2 = (p2End[1] - p2[1]).to_f / (p2End[0] - p2[0])

  b1 = p1[1] - m1 * p1[0]
  b2 = p2[1] - m2 * p2[0]

  px = (b2 - b1) / (m1 - m2)
  py = m1 * px + b1

  if (p1[0] > px && n1[0] > 0 || p1[0] < px && n1[0] < 0) ||
      (p1[1] > py && n1[1] > 0 || p1[1] < py && n1[1] < 0) ||
      (p2[0] > px && n2[0] > 0 || p2[0] < px && n2[0] < 0) ||
      (p2[1] > py && n2[1] > 0 || p2[1] < py && n2[1] < 0)
    return [1/0.0, 1/0.0]
  end
  [px, py]
end

count = 0
(0...input.size-1).each do |i|
  (i+1...input.size).each do |j|
    p1 = [input[i][0], input[i][1]]
    p2 = [input[j][0], input[j][1]]
    n1 = [input[i][3], input[i][4]]
    n2 = [input[j][3], input[j][4]]
    ip = intersection_point(p1, p2, n1, n2)
    if ip[0] >= 200000000000000 && ip[0] <= 400000000000000 && ip[1] >= 200000000000000 && ip[1] <= 400000000000000
      count += 1
    end
  end
end
p count

def rockPos(coord, input)
  possible = Set.new

  input.combination(2).each do |p1, p2|
    p1_coord = p1[coord]
    p1_vel = p1[coord + 3]
    p2_coord = p2[coord]
    p2_vel = p2[coord + 3]

    if p1_vel == p2_vel
      new_possible = Set.new
      diff = p2_coord - p1_coord
      (0..1000).each do |i|
        next if p1_vel == i

        new_possible << i if diff % (i - p1_vel) == 0
      end
      if possible.empty?
        possible = new_possible.clone
      else
        possible = possible & new_possible
      end
    end
  end

  possible.first
end

rock_vel = [rockPos(0, input), rockPos(1, input), rockPos(2, input)]

p1 = input[0]
p2 = input[1]
p1_acc = (p1[4] - rock_vel[1]).to_f / (p1[3] - rock_vel[0])
p2_acc = (p2[4] - rock_vel[1]).to_f / (p2[3] - rock_vel[0])
x_coord = p1[1] - (p1_acc * p1[0])
y_coord = p2[1] - (p2_acc * p2[0])
rock_x = ((y_coord - x_coord) / (p1_acc - p2_acc) + 1).to_i
rock_y = (p1_acc * rock_x + x_coord).to_i
t = (rock_x - p1[0]).to_i / (p1[3] - rock_vel[0])
rock_z = p1[2] + (p1[5] - rock_vel[2]) * t

p rock_x + rock_y + rock_z


