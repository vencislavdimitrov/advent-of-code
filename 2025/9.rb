input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n").map { _1.split(',').map(&:to_i) }

lines = [[input.last, input.first]]
input.each_cons(2) do |p1, p2|
  lines << [p1, p2]
end

def intersection(l1, l2)
  s1_x = l1[1][0] - l1[0][0]
  s1_y = l1[1][1] - l1[0][1]
  s2_x = l2[1][0] - l2[0][0]
  s2_y = l2[1][1] - l2[0][1]

  return false if (-s2_x * s1_y + s1_x * s2_y) == 0 || (-s2_x * s1_y + s1_x * s2_y) == 0

  s = (-s1_y * (l1[0][0] - l2[0][0]) + s1_x * (l1[0][1] - l2[0][1])).to_f / (-s2_x * s1_y + s1_x * s2_y)
  t = ( s2_x * (l1[0][1] - l2[0][1]) - s2_y * (l1[0][0] - l2[0][0])).to_f / (-s2_x * s1_y + s1_x * s2_y)

  return false if s == 0 || t == 0
  return false if s == 1 && t == 1

  s >= 0 && s <= 1 && t >= 0 && t <= 1
end

def square(p1, p2)
  [
    [[[p1[0], p2[0]].min, [p1[1], p2[1]].min], [[p1[0], p2[0]].min, [p1[1], p2[1]].max]],
    [[[p1[0], p2[0]].min, [p1[1], p2[1]].max], [[p1[0], p2[0]].max, [p1[1], p2[1]].max]],
    [[[p1[0], p2[0]].max, [p1[1], p2[1]].max], [[p1[0], p2[0]].max, [p1[1], p2[1]].min]],
    [[[p1[0], p2[0]].max, [p1[1], p2[1]].min], [[p1[0], p2[0]].min, [p1[1], p2[1]].min]]
  ]
end

max_size = 0
max_no_intersection_size = 0
(0...input.size - 1).each do |i|
  (i + 1...input.size).each do |j|
    max_size = [max_size, ((input[i][0] - input[j][0]).abs + 1) * ((input[i][1] - input[j][1]).abs + 1)].max
    sq = square(input[i], input[j])
    if lines.all? { |line| sq.none? { intersection(_1, line) }}
      max_no_intersection_size = [max_no_intersection_size, ((input[i][0] - input[j][0]).abs + 1) * ((input[i][1] - input[j][1]).abs + 1)].max
    end
  end
end
p max_size
p max_no_intersection_size
