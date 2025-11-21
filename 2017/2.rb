input = File.read(File.basename(__FILE__).gsub('rb', 'input')).strip.split("\n").map { _1.split("\t").map(&:to_i) }

p input.sum { _1.max - _1.min }

p input.sum { |line| number = line.find { |n| (line - [n]).any? { n % _1 == 0} }; divisor = (line - [number]).find { number % _1 == 0}; number / divisor }
