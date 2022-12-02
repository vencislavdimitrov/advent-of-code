input = File.read(File.basename(__FILE__).gsub('rb', 'input'))
input = input.split("\n\n").map { _1.split("\n").map(&:to_i).sum }

p input.max

p input.sort.last(3).sum
