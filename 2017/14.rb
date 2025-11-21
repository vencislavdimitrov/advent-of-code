input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip

grid = 128.times.map { input + "-#{_1}" }

def reverse(lengths, n)
  list = (0..255).to_a
  skip = 0
  current = 0
  n.times do
    lengths.each do |length|
      tmp = []
      (0...length).each do |i|
        tmp << list[(current + i) % list.size]
      end
      (0...length).each do |i|
        list[(current + length - 1 - i) % list.size] = tmp[i]
      end
      current += skip + length
      skip += 1
    end
  end
  list
end

knot_grid = grid.map { |g| reverse(g.each_byte.to_a + [17, 31, 73, 47, 23], 64).each_slice(16).map { _1.reduce(&:^).to_s(16) }.map { _1.size == 2 ? _1 : '0' + _1}.join }
binary_grid = knot_grid.map { |knot| knot.chars.map{ |c| c.hex.to_s(2).rjust(4, '0') }.join }

p binary_grid.sum { _1.chars.map(&:to_i).sum }

used = {}
(0...binary_grid.size).each do |i|
  (0...binary_grid[i].size).each do |j|
    used[[i, j]] = 0 if binary_grid[i][j] == '1'
  end
end

group = 1
while used.values.filter { _1 == 0 }.size > 0
  queue = [used.filter { _2 == 0 }.first.first]

  until queue.empty?
    current = queue.pop
    used[current] = group

    queue += [
      [current[0] - 1, current[1]],
      [current[0] + 1, current[1]],
      [current[0], current[1] - 1],
      [current[0], current[1] + 1]
    ].filter { used[_1] == 0 }
  end
  group += 1
end

p used.values.uniq.size
