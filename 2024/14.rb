input = File.read(File.basename(__FILE__).gsub('rb', 'input')).split("\n").map do |m|
  position, velocity = m.split(' ')
  [position[2..].split(',').map(&:to_i), velocity[2..].split(',').map(&:to_i)]
end

x = 101
y = 103
area = input.map { [(_1[0] + 100 * _2[0]) % x, (_1[1] + 100 * _2[1]) % y] }

p area.count { _1 < x / 2 && _2 < y / 2 } *
  area.count { _1 > x / 2 && _2 < y / 2 } *
  area.count { _1 > x / 2 && _2 > y / 2 } *
  area.count { _1 < x / 2 && _2 > y / 2 }

k = 6870
loop do
  area = input.map { [(_1[0] + k * _2[0]) % x, (_1[1] + k * _2[1]) % y] }
  (0...101).each do |i|
    line = ''
    (0...103).each do |j|
      line += area.include?([j, i]) ? '*' : ' '
    end
    puts line
  end
  p k
  # gets
  k += 1
  break
end
