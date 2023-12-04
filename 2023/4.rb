input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
input = input.split("\n").map { _1.split(': ')[1] }

sum = 0
cards = input.size.times.map { 1 }
input.each_with_index do |line, i|
  my = line.split(' | ')[0].split.map(&:to_i)
  winning = line.split(' | ')[1].split.map(&:to_i)

  common = (my & winning).size

  next if common.zero?

  sum += (2**(common - 1))
  common.times do |j|
    cards[i + j + 1] += cards[i]
  end
end

p sum
p cards.sum
