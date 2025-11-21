input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n").map { _1.split(' ').last.to_i }

a, b = input
a_multiplier = 16807
b_multiplier = 48271
divider = 2147483647

judge = 0
40_000_000.times do |i|
  a = (a * a_multiplier) % divider
  b = (b * b_multiplier) % divider

  judge += 1 if a.to_s(2)[-16..] == b.to_s(2)[-16..]
end
p judge

a, b = input
judge = 0
5_000_000.times do |i|
  loop do
    a = (a * a_multiplier) % divider
    break if a % 4 == 0
  end
  loop do
    b = (b * b_multiplier) % divider
    break if b % 8 == 0
  end

  judge += 1 if a.to_s(2)[-16..] == b.to_s(2)[-16..]
end
p judge
