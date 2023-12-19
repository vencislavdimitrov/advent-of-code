input = File.read(File.basename(__FILE__).gsub('rb', 'input')).split("\n").map { _1.split(', ') }

input = input.map { [_1[0][5...-1].split(',').map(&:to_i), _1[1][2..].to_i] }

def manhattan(a, b)
  (a[0] - b[0]).abs + (a[1] - b[1]).abs + (a[2] - b[2]).abs
end

max_radius = input.map { _1[1] }.max
strongest = input.find { _1[1] == max_radius }

p input.count { manhattan(_1[0], strongest[0]) <= strongest[1] }

collisions = {}
(0...input.size).each do |i|
  (i...input.size).each do |j|
    collisions[[i, j]] = manhattan(input[i][0], input[j][0]) <= input[i][1] + input[j][1]
  end
end

def optimized_combinations(collisions, bots, r)
  data = []
  i = 0
  j = 0
  skipped = 0
  loop do
    return data if i == r

    return nil if skipped > bots.length - r || j == bots.length

    bot2 = bots[j]
    all_collide = data[0...i].reduce(true) do |res, bot1|
      res && collisions[[bot1, bot2]]
    end

    data[i] = bots[j]
    j += 1

    if all_collide
      i += 1
    else
      skipped += 1
    end
  end
end

def find_largest_collision(collisions, bots)
  bots.reverse_each do |size|
    collision = optimized_combinations(collisions, bots, size + 1)
    return collision unless collision.nil?
  end
end

collision = find_largest_collision(collisions, (0...input.size).to_a)
puts collision.map { |b| input[b][0].map(&:abs).sum - input[b][1] }.max
