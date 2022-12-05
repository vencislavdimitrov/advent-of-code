input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
input = input.strip.split("\n")

dups = 0
overlap = 0
input.each do |line|
  first, second = line.split(',').map { _1.split('-').map(&:to_i) }

  dups += 1 if first[0] <= second[0] && first[1] >= second[1] || first[0] >= second[0] && first[1] <= second[1]

  overlap += 1 unless first[1] < second[0] || first[0] > second[1]
end

p dups

p overlap
