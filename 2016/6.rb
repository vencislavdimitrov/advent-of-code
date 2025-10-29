input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n").map(&:chars)

res = input[0].clone
input[0].size.times do |i|
  res[i] = input.map { _1[i] }.tally.sort_by { _2 }.last.first
end
p res.join

res = input[0].clone
input[0].size.times do |i|
  res[i] = input.map { _1[i] }.tally.sort_by { _2 }.first.first
end
p res.join

